Return-Path: <linux-kselftest+bounces-20084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027079A31CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C4B284273
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 00:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779FE3BBC1;
	Fri, 18 Oct 2024 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXvKDHaU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B42D7B8;
	Fri, 18 Oct 2024 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212910; cv=none; b=VjOAjB8M3OqtG5iaHVVt5D5yJXk0i4D2y/DpgWNB5UeIW03vnqwiFTgIkzJ2ma8SbfNkJ8RXGHPyxam+ZD9J67HY2ShM0tGw4f8g7KuVSUrXsqMZosv1qRo561pY/3bxarYOzRe+9rZA/MJh3k8yN0MjVzPSPNvCqtO18KrkLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212910; c=relaxed/simple;
	bh=ZZKaLXGN30cfs+dcdPpzULLlMlt+1F43+tVoRH+ipA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtpqTgMJOvwmLQfGFqnMI/X7m4aWHH/ouN7DHrv3XOLBrRZr5EGyyBzxBJr6hLV2U70TvBW2/6mL4MrF95aPcN1+0wStQunzbJfulfZm9Xqgb49a712GCIxQFy/thR9UqDbgbQmnBBZMhhkg4HAwIgY53E+F4OjqfRigRVU+n80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXvKDHaU; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e580256c2so1172822b3a.3;
        Thu, 17 Oct 2024 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729212908; x=1729817708; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5ZC/F1uqpdsB/1iDhHa3vhT4vU1JeAzhuvM2RfqCKsY=;
        b=VXvKDHaUlGySmAQXBlPdzZOlUgpmkLNvY3G0ZxTjsElXBDhiB7AGD9UdW75Q4P5ETc
         yGW3wqwFYrkSvbMiq4xmNWXOn2kPqY1XTh8gygvbDBqdTeTpDXE6ZvIhTmDpzJuMK/cH
         t8EwcEmFNJBux+6by5u7Tfy8rZ0ELyqLkf+evKq3Rtu1uoUbkPYNGw6tND3ARWM1fKnH
         wpQmUkH4mAnIeTKx2WFm/lPeqc29xvHjAa8AtLXF81J3MTOXR2pgF0C30FTPukLQWfpD
         +g4I/rGia9BgWjJFD6KEzkwWwuCujgFzgcbdV9wjoX9Z9wISEW5ubrmCerqOONROBzYk
         qH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729212908; x=1729817708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZC/F1uqpdsB/1iDhHa3vhT4vU1JeAzhuvM2RfqCKsY=;
        b=gmy86UHgyQN49Imt2LifLf9w1Ylbo8rZOQyqcYmGWOGw9EJ4bwZzvqHd5PZ8228Tn0
         1gi0Mz25PxbLILiLUc83/D4/TY/LXCVgo1tcpH4hXakBWIqPNTweIHHfNwCz8zUBAWMB
         /Qw1DPwAPW7S5aWXqXOYn//mxviG+1ukoAGoomXQm0KpvakgwChjAvoIoZ+lm/FmwgEE
         CWgbsUky8nQtqiGctuzk+oKtMLBWIGVMLBAO8JPmwuixui8Hg2QfRnpFop+INpbfpWlR
         AqK82HaA7y6hGgpvyXqfuAKtJlBoqrhd/8jffyZTlUWG1yO7rUBpuorzdwgeOPoqMtbd
         sYOA==
X-Forwarded-Encrypted: i=1; AJvYcCVR/xJAKEwoELHnFdTsZ6hBBerFFK7TjRguCS3TPeSTAwAFyVIDYSeEJWXOUeD9cfsaqz24UH1hv8v8QsfQLOWs@vger.kernel.org, AJvYcCVo1iMsmLfF9SHl+39yp7ovZwrvGCNid9oGsFAwjqaDeW5sF5UnXzhWCV/dqt13QV9ofqyjThnpQUTOBQA=@vger.kernel.org, AJvYcCWFT4nWtnRg7OaheK1rX8WwedGKFnzByrk2ofIfcxQEvyPvyWZPp5MbeTLTAFPEsbioSvzSuSUZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vrEVIyOky7DycazyTJ0ctz3Zq4UZERrn12NgzWaTvKPfXwGk
	/FxRDC35a4vPYw9qCOZa5PavYotwSZiwj4AHix14Ka7mAUx2Owo=
X-Google-Smtp-Source: AGHT+IGmpiY/O/IEgAPUEwZHlshZRZccqN67+CogAKqiJ9fsdVJC18QnIA/KWjJRiChyfnvQM+8F/g==
X-Received: by 2002:a05:6a00:14c4:b0:71d:feb7:37f4 with SMTP id d2e1a72fcca58-71ea31d794cmr1308479b3a.6.1729212907908;
        Thu, 17 Oct 2024 17:55:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea345f93fsm278175b3a.181.2024.10.17.17.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 17:55:07 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:55:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	Liam Howlett <liam.howlett@oracle.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Pei Li <peili.io@oracle.com>
Subject: Re: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Message-ID: <ZxGx6gOHPBP-HVnT@mini-arch>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
 <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>
 <ZxGoQHqXTNW7C7MB@mini-arch>
 <4DDCECB9-86A9-4796-8A27-34113A79C3EC@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4DDCECB9-86A9-4796-8A27-34113A79C3EC@oracle.com>

On 10/18, Anjali Kulkarni wrote:
> 
> 
> > On Oct 17, 2024, at 5:13 PM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > 
> > On 10/17, Anjali Kulkarni wrote:
> >> Kunit tests to test hash table add, delete, duplicate add and delete.
> >> Add following configs and compile kernel code:
> >> 
> >> CONFIG_CONNECTOR=y
> >> CONFIG_PROC_EVENTS=y
> >> CONFIG_NET=y
> >> CONFIG_KUNIT=m
> >> CONFIG_CN_HASH_KUNIT_TEST=m
> >> 
> >> To run kunit tests:
> >> sudo modprobe cn_hash_test
> >> 
> >> Output of kunit tests and hash table contents are displayed in
> >> /var/log/messages (at KERN_DEBUG level).
> >> 
> >> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> >> ---
> >> drivers/connector/cn_hash.c   |  40 ++++++++
> >> drivers/connector/connector.c |  12 +++
> >> include/linux/connector.h     |   4 +
> >> lib/Kconfig.debug             |  17 ++++
> >> lib/Makefile                  |   1 +
> >> lib/cn_hash_test.c            | 167 ++++++++++++++++++++++++++++++++++
> >> lib/cn_hash_test.h            |  10 ++
> >> 7 files changed, 251 insertions(+)
> >> create mode 100644 lib/cn_hash_test.c
> >> create mode 100644 lib/cn_hash_test.h
> >> 
> >> diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
> >> index a079e9bcea6d..40099b5908ac 100644
> >> --- a/drivers/connector/cn_hash.c
> >> +++ b/drivers/connector/cn_hash.c
> >> @@ -170,6 +170,46 @@ int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
> >> return -EINVAL;
> >> }
> >> 
> >> +int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
> >> + int *hkey, int *key_display)
> >> +{
> >> + struct uexit_pid_hnode *hnode;
> >> + int key, count = 0;
> >> +
> >> + mutex_lock(&hdev->uexit_hash_lock);
> >> + key = hash_min(pid, HASH_BITS(hdev->uexit_pid_htable));
> >> + pr_debug("Bucket: %d\n", key);
> >> +
> >> + hlist_for_each_entry(hnode,
> >> + &hdev->uexit_pid_htable[key],
> >> + uexit_pid_hlist) {
> >> + if (key_display[key] != 1) {
> >> + if (hnode->uexit_pid_hlist.next == NULL)
> >> + pr_debug("pid %d ", hnode->pid);
> >> + else
> >> + pr_debug("pid %d --> ", hnode->pid);
> >> + }
> >> + count++;
> >> + }
> >> +
> >> + mutex_unlock(&hdev->uexit_hash_lock);
> >> +
> >> + if ((key_display[key] != 1) && !count)
> >> + pr_debug("(empty)\n");
> >> +
> >> + pr_debug("\n");
> >> +
> >> + *hkey = key;
> >> +
> >> + if (count > max_len) {
> >> + pr_err("%d entries in hlist for key %d, expected %d\n",
> >> + count, key, max_len);
> >> + return -EINVAL;
> >> + }
> >> +
> >> + return 0;
> >> +}
> >> +
> >> bool cn_hash_table_empty(struct cn_hash_dev *hdev)
> >> {
> >> bool is_empty;
> >> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> >> index c1c0dcec53c0..2be2fe1adc12 100644
> >> --- a/drivers/connector/connector.c
> >> +++ b/drivers/connector/connector.c
> >> @@ -304,6 +304,18 @@ int cn_get_exval(pid_t pid)
> >> }
> >> EXPORT_SYMBOL_GPL(cn_get_exval);
> >> 
> >> +int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display)
> >> +{
> >> + struct cn_dev *dev = &cdev;
> >> +
> >> + if (!cn_already_initialized)
> >> + return 0;
> >> +
> >> + return cn_hash_display_hlist(dev->hdev, pid, max_len,
> >> + hkey, key_display);
> >> +}
> >> +EXPORT_SYMBOL_GPL(cn_display_hlist);
> >> +
> >> bool cn_table_empty(void)
> >> {
> >> struct cn_dev *dev = &cdev;
> >> diff --git a/include/linux/connector.h b/include/linux/connector.h
> >> index 5384e4bb98e8..a75c3fcf182a 100644
> >> --- a/include/linux/connector.h
> >> +++ b/include/linux/connector.h
> >> @@ -168,4 +168,8 @@ int cn_get_exval(pid_t pid);
> >> bool cn_table_empty(void);
> >> bool cn_hash_table_empty(struct cn_hash_dev *hdev);
> >> 
> >> +int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display);
> >> +int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
> >> + int *hkey, int *key_display);
> >> +
> >> #endif /* __CONNECTOR_H */
> >> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >> index 7315f643817a..290cf0a6befa 100644
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -2705,6 +2705,23 @@ config HASHTABLE_KUNIT_TEST
> >> 
> >>  If unsure, say N.
> >> 
> >> +config CN_HASH_KUNIT_TEST
> >> + tristate "KUnit Test for connector hashtable code" if !KUNIT_ALL_TESTS
> >> + depends on KUNIT
> >> + default KUNIT_ALL_TESTS
> >> + help
> >> +  This builds the hashtable KUnit test suite.
> >> +  It tests the basic functionality of the API defined in
> >> +  drivers/connector/cn_hash.c.
> >> +  CONFIG_CONNECTOR=y, CONFIG_PROC_EVENTS=y and CONFIG_NET=y needs
> >> +  to be enabled along with CONFIG_CN_HASH_KUNIT_TEST=m and
> >> +  CONFIG_KUNIT=m in .config file to compile and then test as a kernel
> >> +  module with "modprobe cn_hash_test".
> >> +  For more information on KUnit and unit tests in general please
> >> +  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
> >> +
> >> +  If unsure, say N.
> >> +
> > 
> > Looks like this needs to depend on CONFIG_CONNECTOR? Otherwise, the
> > existing kunit tester complains about the missing symbols (see below).
> > Please also hold off reposting for a couple of days to give people some
> > time to review.
> > 
> > ERROR:root:ld: vmlinux.o: in function `cn_hash_test_dup_del':
> > cn_hash_test.c:(.text+0x3e9dc3): undefined reference to `cn_del_get_exval'
> > ld: cn_hash_test.c:(.text+0x3e9dee): undefined reference to `cn_del_get_exval'
> > ld: cn_hash_test.c:(.text+0x3e9e22): undefined reference to `cn_table_empty'
> > ld: vmlinux.o: in function `cn_display_htable':
> > cn_hash_test.c:(.text+0x3e9f67): undefined reference to `cn_display_hlist'
> > ld: vmlinux.o: in function `cn_hash_test_del_get_exval':
> > cn_hash_test.c:(.text+0x3ea037): undefined reference to `cn_del_get_exval'
> > ld: cn_hash_test.c:(.text+0x3ea088): undefined reference to `cn_table_empty'
> > ld: vmlinux.o: in function `cn_hash_test_dup_add':
> > cn_hash_test.c:(.text+0x3ea176): undefined reference to `cn_add_elem'
> > ld: cn_hash_test.c:(.text+0x3ea19e): undefined reference to `cn_get_exval'
> > ld: cn_hash_test.c:(.text+0x3ea1dc): undefined reference to `cn_add_elem'
> > ld: cn_hash_test.c:(.text+0x3ea205): undefined reference to `cn_get_exval'
> > ld: vmlinux.o: in function `cn_hash_test_del':
> > cn_hash_test.c:(.text+0x3ea387): undefined reference to `cn_del_get_exval'
> > ld: cn_hash_test.c:(.text+0x3ea3ab): undefined reference to `cn_get_exval'
> > ld: cn_hash_test.c:(.text+0x3ea3fd): undefined reference to `cn_table_empty'
> > ld: vmlinux.o: in function `cn_hash_test_add':
> > cn_hash_test.c:(.text+0x3ea571): undefined reference to `cn_add_elem'
> > ld: cn_hash_test.c:(.text+0x3ea591): undefined reference to `cn_get_exval'
> > make[3]: *** [../scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > make[2]: *** [/home/kunit/testing/Makefile:1166: vmlinux] Error 2
> > make[1]: *** [/home/kunit/testing/Makefile:224: __sub-make] Error 2
> > make: *** [Makefile:224: __sub-make] Error 2
> 
> Yes, I have added in the comments for CN_HASH_KUNIT_TEST, it depends on:
> CONFIG_CONNECTOR, CONFIG_PROC_EVENTS, CONFIG_NET. I didn’t realize
> I could add these to the “depends” field.
> So something like this: (let me know if you see any issues)
> 
>         tristate "KUnit Test for connector hashtable code" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> +       depends on CONNECTOR && PROC_EVENTS
> +       depends on NET
>         default KUNIT_ALL_TESTS
> 
> These are the configs I add to my .config file and compile it as a module and then
> do modprobe to test.

[..]

> Are you running the kunit tester with kunit.py?

Yes, make sure all required options are picked up by
"./tools/testing/kunit/kunit.py run" instead of manually adding options
and doing modprobe.

