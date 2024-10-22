Return-Path: <linux-kselftest+bounces-20430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DC09ABA36
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 01:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975711C22A9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 23:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C91CEADF;
	Tue, 22 Oct 2024 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIgmsk0N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52D126C05;
	Tue, 22 Oct 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641005; cv=none; b=RTuR7/xxlfUV8jN8SLN2gfY2SbDkD4e0vrNftCCeJ8c0FPXgse3RC/SeaZtt7YVuO95yoM+vIa+KDOppWTwJR20cHJareAQytF/0QUsWrB8hict88uDbMQUG731YeatR0kX+PVfv9cWSks1YpGUqjN0bfkAxZ7QwZSc698lWBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641005; c=relaxed/simple;
	bh=ypW6eo6v9zSPvnsnDFUfPO0qcx3b73uC7Hn+BH1BnWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/T/jKE/JaXi4s7CSUwsc+6wE/EYhavFwR/AKjQidqezJ4IKdWTI24ocdNeoq1ypy1L1TVRI+kripNHl2uzpEDewOJGhYnW87U+W14Bd4jp6iwGkrTxvqjKY71GiREc14DX01g2bCC6DFEKZfzFIPKG4bu0EySO5QavvLI5oMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIgmsk0N; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so4081868a12.2;
        Tue, 22 Oct 2024 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729641003; x=1730245803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jnVOCfl+gfGOtLG2C7UJ+7hJAW/3c0dmYpMokl7m184=;
        b=GIgmsk0NHgFK9eTJtm74fhfUCW1lfQmaJ/QDZJRzlDKf+AfCuE6XXVPFdUyrb9+De0
         tLrCbOm8z9KrhuUAYi93jkWv5w0r93xAN4KJ0NukzhwZ7xGY0qJ5TQp7xb3ZTaIG/uyO
         rHkaPwf3dlyWk/y1gbTjHaSWU9x/h+InEzmGZMYbkFsKDLA+7uXVoGmMUmLupICLQ4S7
         xl0TuokRP6+W45jC6ph7X5h6Yxm80Gqq88uLWou0mZT/XPMkBYhUf6m0Qme3yyQg9vmJ
         4DgUTkP2Y/FVYe0Fi5HAWwcYE896iZQxZnXl4uCZnhQYwgC2cMmj9DCx9ntqkbFhgUoL
         m1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729641003; x=1730245803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnVOCfl+gfGOtLG2C7UJ+7hJAW/3c0dmYpMokl7m184=;
        b=TNY8YZFxI8SKB7+I6w4TZThsEBaQLIFEytxpK0oJmoOrC94tVnO+VVmH82/5jPrG4V
         8n9m1F0B7HqTUYcsffgINNtsCPUpAuUWwaN/UNM+ovQSbsIpDxfNjJ8FHunMrJndLP4n
         QtfSrlSwwQvKuSySb+2cAVNTCqZ9obvOyEZngo7l7XDFzfMp1LWi+8p4LnZp8tbqX4sW
         vdxzWPSXokRuZiJSRWOciTFCO1RowjVUQtqMpJylMiPI/eGGecsCubzvM64d+FLt4oPL
         Tom3PvWb1G+mFSJotrU5oy6gZ+5vcYFkqqjj+V+slsGRFgp0RpLYm3WoCyhtKGQpx8eW
         wVWw==
X-Forwarded-Encrypted: i=1; AJvYcCUs73XNvvKmuREHPwfApy24A2ox6PHKP8FMoMwOSzaWcFiETYbYm7+XiqykdqWf11cjG4XdXaMhyPxBMno=@vger.kernel.org, AJvYcCVz3j2YmgLy98fzxNLCx3HXoTm7KExa/+rUECLSm7Dchni/sbazRY8eZ9sVySiR0ppeE0MqV8AdRX7SBAGlhH0+@vger.kernel.org, AJvYcCXuiNf3fhgj4Ibd4ecMKfSo3KDJlrlbpnz34hi9bhu2PIUZMHJ/FbdUDLgeq0BSYUPBjx7byOpW@vger.kernel.org
X-Gm-Message-State: AOJu0YzSUDslaZQLkdkTSluwhwzdkGuAfao41OM/dXmlrFw/MZJStLmE
	YtZbVJLNn+D+qBnJoC13MhmcgtqeJfFG0KMwrFnB+XNck+qV84U=
X-Google-Smtp-Source: AGHT+IH6itqjLIYrOaOu3IIWCHqQoSAfN9wVXmte4rIKGDx9WFzm0DwT3pZN8MYKD+pG9JMuRfHrBA==
X-Received: by 2002:a05:6a21:670f:b0:1d6:fd8c:fa16 with SMTP id adf61e73a8af0-1d978bd63aemr833578637.46.1729641003193;
        Tue, 22 Oct 2024 16:50:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ff7fsm5268813b3a.71.2024.10.22.16.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 16:50:02 -0700 (PDT)
Date: Tue, 22 Oct 2024 16:50:02 -0700
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
Message-ID: <Zxg6KhhpCGc-5Mw0@mini-arch>
References: <08EFFA25-7C8F-444A-B229-2A9F99B0C028@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08EFFA25-7C8F-444A-B229-2A9F99B0C028@oracle.com>

On 10/22, Anjali Kulkarni wrote:
> 
> 
> > On Oct 17, 2024, at 5:55 PM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > 
> > On 10/18, Anjali Kulkarni wrote:
> >> 
> >> 
> >>> On Oct 17, 2024, at 5:13 PM, Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >>> 
> >>> On 10/17, Anjali Kulkarni wrote:
> >>>> Kunit tests to test hash table add, delete, duplicate add and delete.
> >>>> Add following configs and compile kernel code:
> >>>> 
> >>>> CONFIG_CONNECTOR=y
> >>>> CONFIG_PROC_EVENTS=y
> >>>> CONFIG_NET=y
> >>>> CONFIG_KUNIT=m
> >>>> CONFIG_CN_HASH_KUNIT_TEST=m
> >>>> 
> >>>> To run kunit tests:
> >>>> sudo modprobe cn_hash_test
> >>>> 
> >>>> Output of kunit tests and hash table contents are displayed in
> >>>> /var/log/messages (at KERN_DEBUG level).
> >>>> 
> >>>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> >>>> ---
> >>>> drivers/connector/cn_hash.c   |  40 ++++++++
> >>>> drivers/connector/connector.c |  12 +++
> >>>> include/linux/connector.h     |   4 +
> >>>> lib/Kconfig.debug             |  17 ++++
> >>>> lib/Makefile                  |   1 +
> >>>> lib/cn_hash_test.c            | 167 ++++++++++++++++++++++++++++++++++
> >>>> lib/cn_hash_test.h            |  10 ++
> >>>> 7 files changed, 251 insertions(+)
> >>>> create mode 100644 lib/cn_hash_test.c
> >>>> create mode 100644 lib/cn_hash_test.h
> >>>> 
> >>>> diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
> >>>> index a079e9bcea6d..40099b5908ac 100644
> >>>> --- a/drivers/connector/cn_hash.c
> >>>> +++ b/drivers/connector/cn_hash.c
> >>>> @@ -170,6 +170,46 @@ int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
> >>>> return -EINVAL;
> >>>> }
> >>>> 
> >>>> +int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
> >>>> + int *hkey, int *key_display)
> >>>> +{
> >>>> + struct uexit_pid_hnode *hnode;
> >>>> + int key, count = 0;
> >>>> +
> >>>> + mutex_lock(&hdev->uexit_hash_lock);
> >>>> + key = hash_min(pid, HASH_BITS(hdev->uexit_pid_htable));
> >>>> + pr_debug("Bucket: %d\n", key);
> >>>> +
> >>>> + hlist_for_each_entry(hnode,
> >>>> + &hdev->uexit_pid_htable[key],
> >>>> + uexit_pid_hlist) {
> >>>> + if (key_display[key] != 1) {
> >>>> + if (hnode->uexit_pid_hlist.next == NULL)
> >>>> + pr_debug("pid %d ", hnode->pid);
> >>>> + else
> >>>> + pr_debug("pid %d --> ", hnode->pid);
> >>>> + }
> >>>> + count++;
> >>>> + }
> >>>> +
> >>>> + mutex_unlock(&hdev->uexit_hash_lock);
> >>>> +
> >>>> + if ((key_display[key] != 1) && !count)
> >>>> + pr_debug("(empty)\n");
> >>>> +
> >>>> + pr_debug("\n");
> >>>> +
> >>>> + *hkey = key;
> >>>> +
> >>>> + if (count > max_len) {
> >>>> + pr_err("%d entries in hlist for key %d, expected %d\n",
> >>>> + count, key, max_len);
> >>>> + return -EINVAL;
> >>>> + }
> >>>> +
> >>>> + return 0;
> >>>> +}
> >>>> +
> >>>> bool cn_hash_table_empty(struct cn_hash_dev *hdev)
> >>>> {
> >>>> bool is_empty;
> >>>> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
> >>>> index c1c0dcec53c0..2be2fe1adc12 100644
> >>>> --- a/drivers/connector/connector.c
> >>>> +++ b/drivers/connector/connector.c
> >>>> @@ -304,6 +304,18 @@ int cn_get_exval(pid_t pid)
> >>>> }
> >>>> EXPORT_SYMBOL_GPL(cn_get_exval);
> >>>> 
> >>>> +int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display)
> >>>> +{
> >>>> + struct cn_dev *dev = &cdev;
> >>>> +
> >>>> + if (!cn_already_initialized)
> >>>> + return 0;
> >>>> +
> >>>> + return cn_hash_display_hlist(dev->hdev, pid, max_len,
> >>>> + hkey, key_display);
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(cn_display_hlist);
> >>>> +
> >>>> bool cn_table_empty(void)
> >>>> {
> >>>> struct cn_dev *dev = &cdev;
> >>>> diff --git a/include/linux/connector.h b/include/linux/connector.h
> >>>> index 5384e4bb98e8..a75c3fcf182a 100644
> >>>> --- a/include/linux/connector.h
> >>>> +++ b/include/linux/connector.h
> >>>> @@ -168,4 +168,8 @@ int cn_get_exval(pid_t pid);
> >>>> bool cn_table_empty(void);
> >>>> bool cn_hash_table_empty(struct cn_hash_dev *hdev);
> >>>> 
> >>>> +int cn_display_hlist(pid_t pid, int max_len, int *hkey, int *key_display);
> >>>> +int cn_hash_display_hlist(struct cn_hash_dev *hdev, pid_t pid, int max_len,
> >>>> + int *hkey, int *key_display);
> >>>> +
> >>>> #endif /* __CONNECTOR_H */
> >>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> >>>> index 7315f643817a..290cf0a6befa 100644
> >>>> --- a/lib/Kconfig.debug
> >>>> +++ b/lib/Kconfig.debug
> >>>> @@ -2705,6 +2705,23 @@ config HASHTABLE_KUNIT_TEST
> >>>> 
> >>>> If unsure, say N.
> >>>> 
> >>>> +config CN_HASH_KUNIT_TEST
> >>>> + tristate "KUnit Test for connector hashtable code" if !KUNIT_ALL_TESTS
> >>>> + depends on KUNIT
> >>>> + default KUNIT_ALL_TESTS
> >>>> + help
> >>>> +  This builds the hashtable KUnit test suite.
> >>>> +  It tests the basic functionality of the API defined in
> >>>> +  drivers/connector/cn_hash.c.
> >>>> +  CONFIG_CONNECTOR=y, CONFIG_PROC_EVENTS=y and CONFIG_NET=y needs
> >>>> +  to be enabled along with CONFIG_CN_HASH_KUNIT_TEST=m and
> >>>> +  CONFIG_KUNIT=m in .config file to compile and then test as a kernel
> >>>> +  module with "modprobe cn_hash_test".
> >>>> +  For more information on KUnit and unit tests in general please
> >>>> +  refer to the KUnit documentation in Documentation/dev-tools/kunit/.
> >>>> +
> >>>> +  If unsure, say N.
> >>>> +
> >>> 
> >>> Looks like this needs to depend on CONFIG_CONNECTOR? Otherwise, the
> >>> existing kunit tester complains about the missing symbols (see below).
> >>> Please also hold off reposting for a couple of days to give people some
> >>> time to review.
> >>> 
> >>> ERROR:root:ld: vmlinux.o: in function `cn_hash_test_dup_del':
> >>> cn_hash_test.c:(.text+0x3e9dc3): undefined reference to `cn_del_get_exval'
> >>> ld: cn_hash_test.c:(.text+0x3e9dee): undefined reference to `cn_del_get_exval'
> >>> ld: cn_hash_test.c:(.text+0x3e9e22): undefined reference to `cn_table_empty'
> >>> ld: vmlinux.o: in function `cn_display_htable':
> >>> cn_hash_test.c:(.text+0x3e9f67): undefined reference to `cn_display_hlist'
> >>> ld: vmlinux.o: in function `cn_hash_test_del_get_exval':
> >>> cn_hash_test.c:(.text+0x3ea037): undefined reference to `cn_del_get_exval'
> >>> ld: cn_hash_test.c:(.text+0x3ea088): undefined reference to `cn_table_empty'
> >>> ld: vmlinux.o: in function `cn_hash_test_dup_add':
> >>> cn_hash_test.c:(.text+0x3ea176): undefined reference to `cn_add_elem'
> >>> ld: cn_hash_test.c:(.text+0x3ea19e): undefined reference to `cn_get_exval'
> >>> ld: cn_hash_test.c:(.text+0x3ea1dc): undefined reference to `cn_add_elem'
> >>> ld: cn_hash_test.c:(.text+0x3ea205): undefined reference to `cn_get_exval'
> >>> ld: vmlinux.o: in function `cn_hash_test_del':
> >>> cn_hash_test.c:(.text+0x3ea387): undefined reference to `cn_del_get_exval'
> >>> ld: cn_hash_test.c:(.text+0x3ea3ab): undefined reference to `cn_get_exval'
> >>> ld: cn_hash_test.c:(.text+0x3ea3fd): undefined reference to `cn_table_empty'
> >>> ld: vmlinux.o: in function `cn_hash_test_add':
> >>> cn_hash_test.c:(.text+0x3ea571): undefined reference to `cn_add_elem'
> >>> ld: cn_hash_test.c:(.text+0x3ea591): undefined reference to `cn_get_exval'
> >>> make[3]: *** [../scripts/Makefile.vmlinux:34: vmlinux] Error 1
> >>> make[2]: *** [/home/kunit/testing/Makefile:1166: vmlinux] Error 2
> >>> make[1]: *** [/home/kunit/testing/Makefile:224: __sub-make] Error 2
> >>> make: *** [Makefile:224: __sub-make] Error 2
> >> 
> >> Yes, I have added in the comments for CN_HASH_KUNIT_TEST, it depends on:
> >> CONFIG_CONNECTOR, CONFIG_PROC_EVENTS, CONFIG_NET. I didn’t realize
> >> I could add these to the “depends” field.
> >> So something like this: (let me know if you see any issues)
> >> 
> >>        tristate "KUnit Test for connector hashtable code" if !KUNIT_ALL_TESTS
> >>        depends on KUNIT
> >> +       depends on CONNECTOR && PROC_EVENTS
> >> +       depends on NET
> >>        default KUNIT_ALL_TESTS
> >> 
> >> These are the configs I add to my .config file and compile it as a module and then
> >> do modprobe to test.
> > 
> > [..]
> > 
> >> Are you running the kunit tester with kunit.py?
> > 
> > Yes, make sure all required options are picked up by
> > "./tools/testing/kunit/kunit.py run" instead of manually adding options
> > and doing modprobe.
> 
> The environment issues are resolved and I am able to run kunit.py, but my tests
> are not invoked without giving options via —kconfig-add. Other tests are also not
> invoked. Running with the manual options runs 413 tests, and with just kunit.py
> runs 389 tests. (I have added 6). Any idea how I can make it run my tests?

The runner does: ./tools/testing/kunit/kunit.py run --alltests
Is it not enough in your case? What options do you pass via
--kconfig-add? Is it because CONNECTOR stuff is disabled by default?

