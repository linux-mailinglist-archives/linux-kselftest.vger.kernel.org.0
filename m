Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732916B82FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 21:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCMUlc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 16:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCMUlb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 16:41:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894AE189
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Mar 2023 13:40:58 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k17so5561389iob.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Mar 2023 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678740054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0T+Km9cavSQaDYPpPQXfU9zdS3Tn01gJlo4SYSaGTsQ=;
        b=TQATrXuUbv73UnY+1AoZezSFrjnoWb6XBb4KKmy55Dz6xoRMZMU5Lk5mVbE/yBcLoS
         uielXBVD5Xil2P2hsyGwgq3sdGc01SpHIjc9oWqTjvvue5SLYFhijuaVnRJjZY8gDNOh
         ZTvdnJYkRVLx6HpXv7gMdi7CWdOgEwoykKcbtHLrJZ8A/WwLPpcEoLzGE7malfTUYJjd
         iSVCqvSgQAD7jOwK0C0ecMYOFtRxx6gjS8WryAOQFoPuQV79KsFJoh8X2QvDhTcPIfs9
         qELFz6z7V3giyT7opexr6QgITwDZrGVqYPaijuP+BS4ZDSv/mCQxNh03E+/46usgG7CZ
         zZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678740054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0T+Km9cavSQaDYPpPQXfU9zdS3Tn01gJlo4SYSaGTsQ=;
        b=hFQDnL1CuSG+1NUMUojHfJjyeI8OzQX3+LcbefdUOzWH0rVCa8tS62Ft+ViSiVIJ3u
         CL483PuORrA/Pi+nEdWFw/H/TKCR9zxCTmQ5NAr920jjyq0cUAEov77G7hB7rSArbEj8
         8MorvNH33qFW2P/f1W6WWIBKdbaqMbECP23Jod2i6pGq0rRrgGHlfqZqy0u86oI6Ql4u
         mYIhtydgiWr/ONT1BvfOsIECUmSfUWAKoiTbmHk6akdlmE45X6RUwACq5k3mdRzQaDRz
         eGioG+1WisrosehO+Gi1vdH+J5OiigNtf1uUc/0q8jeV+ZNYvNNGubALLHXnzuLuVgTg
         b+LA==
X-Gm-Message-State: AO0yUKWQ9OxFH5XxCzq4GRmyObMqnRTZ1a9ARnSMUlte+T8KsZ7boNRh
        0enh83+RBhp0vIHnlXJEnaU5KQ==
X-Google-Smtp-Source: AK7set/xW8ytFvQ8KfIVjFvFDObW2b6jVdvNOP69AGFe4AmpmWOEiHtIGspIfm9vNvggXDisP45jHw==
X-Received: by 2002:a5e:8819:0:b0:74d:114c:832b with SMTP id l25-20020a5e8819000000b0074d114c832bmr24055572ioj.20.1678740054335;
        Mon, 13 Mar 2023 13:40:54 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:a33c:9b70:2c95:9544])
        by smtp.gmail.com with ESMTPSA id h14-20020a0566380f8e00b003c4e3ecb02dsm189549jal.24.2023.03.13.13.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:40:54 -0700 (PDT)
Date:   Mon, 13 Mar 2023 14:40:50 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: use canonical ftrace path
Message-ID: <20230313204050.GA592900@google.com>
References: <20230310175209.2130880-1-zwisler@kernel.org>
 <20230310175209.2130880-2-zwisler@kernel.org>
 <20230310183352.2943e633@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310183352.2943e633@gandalf.local.home>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 06:33:52PM -0500, Steven Rostedt wrote:
> On Fri, 10 Mar 2023 10:52:09 -0700
> zwisler@kernel.org wrote:
> 
> > diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
> > index 156743cf5870..4fa61ac8a0ee 100644
> > --- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
> > +++ b/tools/testing/selftests/bpf/get_cgroup_id_user.c
> > @@ -86,8 +86,12 @@ int main(int argc, char **argv)
> >  	pid = getpid();
> >  	bpf_map_update_elem(pidmap_fd, &key, &pid, 0);
> >  
> > -	snprintf(buf, sizeof(buf),
> > -		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> > +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> > +		snprintf(buf, sizeof(buf),
> > +			 "/sys/kernel/tracing/events/%s/id", probe_name);
> > +	else
> > +		snprintf(buf, sizeof(buf),
> > +			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> 
> I don't know how the BPF folks feel, but I do know some kernel developers
> prefer that if you need to break a single command into multiple lines that
> you then need to add brackets around it. As it makes it easier to read.
> 
> 	if (access("/sys/kernel/tracing/trace", F_OK) == 0) {
> 		snprintf(buf, sizeof(buf),
> 			 "/sys/kernel/tracing/events/%s/id", probe_name);
> 	} else {
> 		snprintf(buf, sizeof(buf),
> 			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> 	}
> 
> 
> 
> >  	efd = open(buf, O_RDONLY, 0);
> >  	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
> >  		goto close_prog;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index 113dba349a57..22be0a9a5a0a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -338,7 +338,12 @@ static int get_syms(char ***symsp, size_t *cntp, bool kernel)
> >  	 * Filtering out duplicates by using hashmap__add, which won't
> >  	 * add existing entry.
> >  	 */
> > -	f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> > +
> > +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> > +		f = fopen("/sys/kernel/tracing/available_filter_functions", "r");
> > +	else
> > +		f = fopen("/sys/kernel/debug/tracing/available_filter_functions", "r");
> > +
> >  	if (!f)
> >  		return -EINVAL;
> >  
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> > index c717741bf8b6..60f92fd3c37a 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
> > @@ -17,8 +17,12 @@ static void test_task_fd_query_tp_core(const char *probe_name,
> >  	if (CHECK(err, "bpf_prog_test_load", "err %d errno %d\n", err, errno))
> >  		goto close_prog;
> >  
> > -	snprintf(buf, sizeof(buf),
> > -		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> > +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> > +		snprintf(buf, sizeof(buf),
> > +			 "/sys/kernel/tracing/events/%s/id", probe_name);
> > +	else
> > +		snprintf(buf, sizeof(buf),
> > +			 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
> 
> Same here.
> 
> >  	efd = open(buf, O_RDONLY, 0);
> >  	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
> >  		goto close_prog;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> > index 770fcc3bb1ba..d3e377fa8e9b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
> > @@ -16,8 +16,12 @@ void serial_test_tp_attach_query(void)
> >  	for (i = 0; i < num_progs; i++)
> >  		obj[i] = NULL;
> >  
> > -	snprintf(buf, sizeof(buf),
> > -		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
> > +	if (access("/sys/kernel/tracing/trace", F_OK) == 0)
> > +		snprintf(buf, sizeof(buf),
> > +			 "/sys/kernel/tracing/events/sched/sched_switch/id");
> > +	else
> > +		snprintf(buf, sizeof(buf),
> > +			 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
> 
> and here.
> 
> But perhaps the BPF folks don't care?

Sure, I agree that this is more readable.  I'll gather your Reviewed-by for
patch #1, make this change, rebase to the current bpf/bpf-next and send out
v4.
