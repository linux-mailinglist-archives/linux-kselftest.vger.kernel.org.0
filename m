Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC64FA15F
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Apr 2022 03:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiDIBq7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 21:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237880AbiDIBq5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 21:46:57 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433FD1F7;
        Fri,  8 Apr 2022 18:44:51 -0700 (PDT)
Date:   Fri, 8 Apr 2022 18:44:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1649468689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EaX3YgB0MApk9e4iRjxSG36z1CKX5ZmC5rxuBJrAT1I=;
        b=Vixq1q2y5mYbpP/5yFzoxE2p8QT9ZaBPN3CZfPu8M6T1WxyX2Cjs6NG7W2u0hgjxEtiPUj
        izMhNEY5Lzn7v6MQUq8o8CwUXAHtKC4iot5I1bpTC06nkdx20W/LUiIFrHhvmM0P7FoySf
        KafxyE6FxCpvxWU/7sY2sdL/I6w2VcA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/4] selftests: cgroup: return the errno of write() in
 cg_write() on failure
Message-ID: <YlDlCRSyR9xNW5dJ@carbon.dhcp.thefacebook.com>
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-3-yosryahmed@google.com>
 <CAJD7tkb6VJt=pfqnW11r6S7A0r2Vh85a3YZaVso-qyiCM06nDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkb6VJt=pfqnW11r6S7A0r2Vh85a3YZaVso-qyiCM06nDQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 08, 2022 at 06:21:55PM -0700, Yosry Ahmed wrote:
> On Thu, Apr 7, 2022 at 9:57 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Currently, cg_write() returns 0 on success and -1 on failure. Modify it
> > to return the errno of write() syscall when write() fails.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  tools/testing/selftests/cgroup/cgroup_util.c | 32 +++++++++++---------
> >  1 file changed, 17 insertions(+), 15 deletions(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> > index dbaa7aabbb4a..3b6bb09985fa 100644
> > --- a/tools/testing/selftests/cgroup/cgroup_util.c
> > +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> > @@ -38,23 +38,23 @@ static ssize_t read_text(const char *path, char *buf, size_t max_len)
> >         return len;
> >  }
> >
> > -static ssize_t write_text(const char *path, char *buf, ssize_t len)
> > +/*
> > + * Returns:
> > + *     success -> 0
> > + *     open() failure -> -1
> > + *     write() failure -> errno
> > + */
> > +static int write_text(const char *path, char *buf, ssize_t len)
> >  {
> > -       int fd;
> > +       int fd, ret;
> >
> >         fd = open(path, O_WRONLY | O_APPEND);
> >         if (fd < 0)
> >                 return fd;
> >
> > -       len = write(fd, buf, len);
> > -       if (len < 0) {
> > -               close(fd);
> > -               return len;
> > -       }
> > -
> > +       ret = write(fd, buf, len) < 0 ? errno : 0;
> >         close(fd);
> > -
> > -       return len;
> > +       return ret;
> >  }
> >
> >  char *cg_name(const char *root, const char *name)
> > @@ -177,17 +177,19 @@ long cg_read_lc(const char *cgroup, const char *control)
> >         return cnt;
> >  }
> >
> > +/*
> > + * Returns:
> > + *     success -> 0
> > + *     open() failure -> -1
> > + *     write() failure -> errno
> > + */
> >  int cg_write(const char *cgroup, const char *control, char *buf)
> >  {
> >         char path[PATH_MAX];
> >         ssize_t len = strlen(buf);
> >
> >         snprintf(path, sizeof(path), "%s/%s", cgroup, control);
> > -
> > -       if (write_text(path, buf, len) == len)
> > -               return 0;
> > -
> > -       return -1;
> > +       return write_text(path, buf, len);
> >  }
> 
> I have changed this in v4 to a cleaner implementation that either
> returns 0 on success or -errno on failure. I also made sure to check
> that the full buffer was being written, and updated cg_read() as well
> for the interface to be consistent.
> 
> Will send out once the discussion on patch 1 in v3 reaches a consensus.

Ok, sounds good, please feel free to add my
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for the whole series. It looks really nice and ready for merging upstream to me.

Thanks!
