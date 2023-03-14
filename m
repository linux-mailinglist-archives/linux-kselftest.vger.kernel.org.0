Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA16B8A46
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 06:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCNF1h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 01:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCNF1f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 01:27:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A4F8F529;
        Mon, 13 Mar 2023 22:27:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so6518350pjb.0;
        Mon, 13 Mar 2023 22:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678771654;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4D03rED555IfCoQrbUz4ZWLp8DNJPBkSCZrRpWNZxMU=;
        b=PHK/eH6cxnMBDS+FpMlgzW09AXUjOoOlj8ASxxz2aTuLTVeKSUp7xKHTxKB7/Vcnkl
         CwrVvnjVsspQikiPLvqlnnjBDOxS40eWdvJsSUGxDU9E81cNPnOowcX7tvis4axPax1e
         vSywQecGqxKImEGF0uFw76T+kBlaJxqgol80grFJZkUz5kLNctM8vh3mtCgSko4Br0zB
         XYfcFPVNVBkNm0OVf5Gv+KmHUfO9wlIw6xyR7Qh9BkdAGnnE+V6K5jyl3saNZFDyiF2U
         BQBfFni82qvs4AvD+UDTygqlI33Uc561jC+hN2hOzrWdEFbRj8XdWiOJvOYvh9ZCYTSI
         vyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678771654;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4D03rED555IfCoQrbUz4ZWLp8DNJPBkSCZrRpWNZxMU=;
        b=DlsHwLFi6G4pF6Bh7cnD+PkE3ygxTqhqwtepAkiFWzjy58spAdQGK+D0Xhcs/pvguT
         BM141plrOlYp7gPDh151BxpbH+vrlTHbE8N2Msed0zEhVmSgC59v7y1t3VO9lOeahOQU
         ZlYQJA5a30l/0mDwBLCAkosaI3g3MkmlxThsbib7bkvp7AosCPo5gfbH+vaaRwZQXBFB
         TBDuhg8EPS2oXRxkMieRdX429l4Lf/mCSKDX3P22EjzJWxqXFHVuZx+peTVJx2nMvrQq
         Wu8xD2g1EEiE6lA+PVXY76NJs1SbhY5bdSvsVvaVasYmB/JKMgMKROSsGE/GAbBTxGSz
         PFbg==
X-Gm-Message-State: AO0yUKURnHXDkAOK+QAwPsf7wcNMPBO+mSCqMAvi6BcHUEu/sznu74HC
        fxCSZzihvXAMBpuQd+wJuLY=
X-Google-Smtp-Source: AK7set/4mOlSqk9UfChalfQ+S/QeZHZ3bmvtWmPxEpzecYyp26RBTvUEq8a4As4Nzv6DpHtOhUGiNw==
X-Received: by 2002:a17:902:d54f:b0:19e:73a9:c21b with SMTP id z15-20020a170902d54f00b0019e73a9c21bmr34729856plf.45.1678771654019;
        Mon, 13 Mar 2023 22:27:34 -0700 (PDT)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b0019a7d6a9a76sm758621plb.111.2023.03.13.22.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 22:27:33 -0700 (PDT)
Date:   Mon, 13 Mar 2023 22:27:32 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     zwisler@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, linux-kselftest@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <641005c453661_4258120826@john.notmuch>
In-Reply-To: <20230313204050.GA592900@google.com>
References: <20230310175209.2130880-1-zwisler@kernel.org>
 <20230310175209.2130880-2-zwisler@kernel.org>
 <20230310183352.2943e633@gandalf.local.home>
 <20230313204050.GA592900@google.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: use canonical ftrace path
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ross Zwisler wrote:
> On Fri, Mar 10, 2023 at 06:33:52PM -0500, Steven Rostedt wrote:
> > On Fri, 10 Mar 2023 10:52:09 -0700
> > zwisler@kernel.org wrote:
> > 
> > > diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
> > > index 156743cf5870..4fa61ac8a0ee 100644
> > > --- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
> > > +++ b/tools/testing/selftests/bpf/get_cgroup_id_user.c
> > > @@ -86,8 +86,12 @@ int main(int argc, char **argv)
> > >  	pid = getpid();
> > >  	bpf_map_update_elem(pidmap_fd, &key, &pid, 0);
> > >  
> > > -	snprintf(buf, sizeof(buf),
> > > -		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> > > +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> > > +		snprintf(buf, sizeof(buf),
> > > +			 "/sys/kernel/tracing/events/%s/id", probe_name);
> > > +	else
> > > +		snprintf(buf, sizeof(buf),
> > > +			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> > 
> > I don't know how the BPF folks feel, but I do know some kernel developers
> > prefer that if you need to break a single command into multiple lines that
> > you then need to add brackets around it. As it makes it easier to read.
> > 
> > 	if (access("/sys/kernel/tracing/trace", F_OK) == 0) {
> > 		snprintf(buf, sizeof(buf),
> > 			 "/sys/kernel/tracing/events/%s/id", probe_name);
> > 	} else {
> > 		snprintf(buf, sizeof(buf),
> > 			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> > 	}
> > 
> > 
> > 
> > >  	efd = open(buf, O_RDONLY, 0);
> > >  	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
> > >  		goto close_prog;
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > index 113dba349a57..22be0a9a5a0a 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > > @@ -338,7 +338,12 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
> > >  	 * Filtering out duplicates by using hashmap__add, which won't
> > >  	 * add existing entry.
> > >  	 */
> > > -	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> > > +
> > > +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> > > +		f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
> > > +	else
> > > +		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> > > +
> > >  	if (!f)
> > >  		return -EINVAL;
> > >  
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> > > index c717741bf8b6..60f92fd3c37a 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> > > @@ -17,8 +17,12 @@ static void test_task_fd_query_tp_core(const char *probe_name,
> > >  	if (CHECK(err, "bpf_prog_test_load", "err %d errno %d\n", err, errno))
> > >  		goto close_prog;
> > >  
> > > -	snprintf(buf, sizeof(buf),
> > > -		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> > > +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> > > +		snprintf(buf, sizeof(buf),
> > > +			 "/sys/kernel/tracing/events/%s/id", probe_name);
> > > +	else
> > > +		snprintf(buf, sizeof(buf),
> > > +			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> > 
> > Same here.
> > 
> > >  	efd = open(buf, O_RDONLY, 0);
> > >  	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
> > >  		goto close_prog;
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> > > index 770fcc3bb1ba..d3e377fa8e9b 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> > > @@ -16,8 +16,12 @@ void serial_test_tp_attach_query(void)
> > >  	for (i = 0; i < num_progs; i++)
> > >  		obj[i] = NULL;
> > >  
> > > -	snprintf(buf, sizeof(buf),
> > > -		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
> > > +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> > > +		snprintf(buf, sizeof(buf),
> > > +			 "/sys/kernel/tracing/events/sched/sched_switch/id");
> > > +	else
> > > +		snprintf(buf, sizeof(buf),
> > > +			 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
> > 
> > and here.
> > 
> > But perhaps the BPF folks don't care?
> 
> Sure, I agree that this is more readable.  I'll gather your Reviewed-by for
> patch #1, make this change, rebase to the current bpf/bpf-next and send out
> v4.


Also for the patch. LGTM

Acked-by: John Fastabend <john.fastabend@gmail.com>
