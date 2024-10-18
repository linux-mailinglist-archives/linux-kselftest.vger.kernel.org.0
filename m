Return-Path: <linux-kselftest+bounces-20140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417C29A412F
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF01285B09
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDCF1C242D;
	Fri, 18 Oct 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvCGuWON"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBBA7BAEC;
	Fri, 18 Oct 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261857; cv=none; b=oVUL+Ioz/IEMnmBpiKcgykT8xbf/oX5eHRZNrN+88SR434tFrKHeC2hTumPhg7IIzE1VdOR2cxVY+ZJklf6x/QUpfVxX7vj3iC6nQSiQX7MYCfyfm+c1IxpANxcK2xBJkqsPPt1+1UhBZuRS1uR6depDEpurhuMk0YFFUL/9omY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261857; c=relaxed/simple;
	bh=P1gbs3YZf02PGoZkmPDCAV+XAk2k6Y2U03IPDpoWFoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPfrp6ooHqFk9nlapCUllGoxjDMR6xF/MKjEHfNhiJ8t9oCzJKvWUKu/s3nDwW+mRCZWs0CGPA43NCRJ1ZYWCLRmUoBVDGFwF52/w7wQoZyuXsh52640Go106dJ+73foxcEl7fCXZ9dyLrKF8ZwKU0skLvDVchccya1SSczS/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvCGuWON; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3b4663e40so9243795ab.2;
        Fri, 18 Oct 2024 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729261855; x=1729866655; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9a5S7GYTwvYZq4pcn+pZXVfllhtPa7p/a7lhHUjDdkw=;
        b=hvCGuWONf7YJRhZUAD0mYcmtOs0Y4jLmqlEKFCI8Yea8FYmsHYu4WXFpZaaY2EyJ9G
         Nwna88mSYOfrpuxCbSb+4J/bm4leUpfCvCcUwkcJhg5ivZY6zG+7Zs5vhH/VOeqY12b+
         UQ69VenhmxG78yizzMq6mukXqm/nBOobKwdm/MsVw/AfdZXc/QKcJ244qvkaTb2TQh7c
         UQUTxi/EYkSdeOTkA1O0cKuO8+/tYOdEgLJFBIqndUdUNrkJIqskJHYHWUjLKtseDBJJ
         5FVLbXgWO3zJfNs1/0MlkQy5xl5ZH7f/sugVNVP7vj8ZjfWrtUjlbLcpG1LD/T7bBZ3d
         IUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729261855; x=1729866655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9a5S7GYTwvYZq4pcn+pZXVfllhtPa7p/a7lhHUjDdkw=;
        b=BQlPemsUjWV7doilsJOIqpCWyaDinh4XKgI7Vq4cp54ukzYN7jMImqZL55wGKg9rjC
         aLIJPwXWPdi8OCrU+I3LPBnX6Z7D9itvpUMqSMlLeRsgUllK+mbEFZCP2ANqSLFYGwp/
         Bh9qaanpQM1sGbKlMxVkQx4K9e7xHYATIzU96aJjsSd+kb5PQmupLsAlDTkK6mm8SfTc
         thoGUwlEFl05OIl95OI+J+gJLligXO6ct4oTLUJQ0QuHHEpAJpQ08uzdu3pCjSpTytur
         tK2qMIV0g+ITtDiEGahMLpIpWJlF3NDB5Pva2qc5spjZOTM6eyqPNNgSOhruVhZMXigi
         nK2w==
X-Forwarded-Encrypted: i=1; AJvYcCUQjKZoDKv5e9ytnC0AsbpD0h538YugAnaAnmKWQ4MbjZsh+INS8bsRbC/FDHTU+9A3JtCK2x1f7u65n6tmAN+t@vger.kernel.org, AJvYcCUS/Mn7KuA7pUCAYskmOm3pjOnRuvJ86U2eJ7bvQ3MAdesywgDW/MURcn+GTyPfbOi7AhOQn7ynvyK6VVM=@vger.kernel.org, AJvYcCXMD5hLru4S6mrMEuGM4AWBbGwNQqulLA/bhQxYv6e6MNL2scZIN+acXqlE521fQSGTwXGfGYyI@vger.kernel.org
X-Gm-Message-State: AOJu0Yydkz97SUK0Yf/ACaFvElhmu8Y2nZgLhovTX5Tk2EXxZmxF3tCR
	E2vQ+C8bmh+RSWCXobgaxeZHu13PGTxw49LIa2Y8TaNRmk0K3pM=
X-Google-Smtp-Source: AGHT+IH+QoOa26N0Erhw+ptLLPgFhL5FYTZ38jZXnYxHygiVbUsDwjz4b7qe+P3y6RdaKyy3BDfh1A==
X-Received: by 2002:a05:6e02:1a06:b0:3a0:b0dc:abfe with SMTP id e9e14a558f8ab-3a3f409f362mr28024625ab.17.1729261854491;
        Fri, 18 Oct 2024 07:30:54 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc29f723sm1376996a12.91.2024.10.18.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 07:30:53 -0700 (PDT)
Date: Fri, 18 Oct 2024 07:30:53 -0700
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
Message-ID: <ZxJxHaodJu1Wcgcb@mini-arch>
References: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
 <20241017181436.2047508-3-anjali.k.kulkarni@oracle.com>
 <ZxGoQHqXTNW7C7MB@mini-arch>
 <4DDCECB9-86A9-4796-8A27-34113A79C3EC@oracle.com>
 <ZxGx6gOHPBP-HVnT@mini-arch>
 <B227B573-F9DF-4063-9A20-787504091DCB@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B227B573-F9DF-4063-9A20-787504091DCB@oracle.com>

On 10/18, Anjali Kulkarni wrote:
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
> I’m unable to run kunit.py, it runs into various issues like UML, permissions, other 
> errors. I talked to the kunit guys about this and we have been debugging it for a
> while but unable to fix the environment issue. But the tests work fine.
> 
> What kind of VM is this being run on? Like ubuntu etc.? I will try on a different
> OS and check if kunit.py works. 

It's running on fedora.

