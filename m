Return-Path: <linux-kselftest+bounces-35591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F5DAE344D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 06:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CEC7A1749
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 04:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325681B85CC;
	Mon, 23 Jun 2025 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="j76InUmz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A352FB2;
	Mon, 23 Jun 2025 04:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750652576; cv=pass; b=dObK/bZBLamREc6QsZ/xYt60OYHdb0cSg9mS01O3G9XbYHDNxWRipIhbPZ+n47G79bsBHsJCqjZnn2U+do3NkI3lDG8kxAC5IL2Gq8xDgs6X1zVNr3//zOol5f3TIOHklslqYQWikgnLd2z0AqKDN56K2g+wZkvEfONBK170tO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750652576; c=relaxed/simple;
	bh=q9h1Zu5Ol6SLyA6ymFUAZPl1yFWJTcGqAKQmxynmf3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkARu++Z91KrGREJIQIfQGMgcURzJ6aM3c7O2n3pShwjiamEOnXQaWJcpJcckTW8AvP2iNdELBcl5YwRsvywuwglRHxlvAUjjtTWABJxeihXbB/uoVEzvzlZneTR2I+uf+jdm8HBVBK8DLz0KmOuuf/HOP77UhtGz8vAMqTuxX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=j76InUmz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750652551; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nio7iI08OincqbdaECjbl4hhoPYw1puSM4LVgnWL3YjVLqMQsxlpWPCqZPCNB2SuPMcuAWW1Uo1U/N7YYY5DcyiHFs8u6FU+NeHW2wB2+j1V6S55dBK43p+qruN3+wJtUURrzmtMY4YPxwPSbwd5NnsvAf9WY54l7grq6wCFBVQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750652551; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nyr1QBpT/cq5OQ5ZrMG6Eq7xXww1oQmtMkfRYQ9Gas0=; 
	b=NtLZFYiMhys/O+FpcRo5/6NhfavtIrciLLp0sweORxtTnSUUjHO3PvIFJnhwtrizbJSS62IsJBZ9DO4CXJyr9ajx3xzod9iHyFwmiLDCV9oS3wBls78/QYARXbAyzXdDCGHhQb3D0jwi+VSpbmTN3Y/7CbZb4WDCzRNliTt9dzI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750652551;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nyr1QBpT/cq5OQ5ZrMG6Eq7xXww1oQmtMkfRYQ9Gas0=;
	b=j76InUmzHm1Tz5epcAcio4sMr9YDaSTaetUpzaXuVWsVNmN0SzizeWvJ9Pa8oURo
	KCIsdpiuAsDnXaZypj9ordlq9r9IA7EcV1DutqLhPat7xgdbbJunc1mvI6LJmb2HsfO
	iKwK1vg7dAJFO+RzHWEm16RzKRtrQpFZ0adQfXB0=
Received: by mx.zohomail.com with SMTPS id 1750652549950418.8510153490747;
	Sun, 22 Jun 2025 21:22:29 -0700 (PDT)
Message-ID: <f9b2deab-bdc4-4fd4-be1b-cb6617060086@collabora.com>
Date: Mon, 23 Jun 2025 09:22:31 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/filesystems/mount-notify: fix unused unused
 result warning
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, John Hubbard <jhubbard@nvidia.com>,
 Miklos Szeredi <mszeredi@redhat.com>, Jan Kara <jack@suse.cz>,
 zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620035125.2938774-2-chenlinxuan@uniontech.com>
 <213adda0-1db2-46e7-9342-cc97fbd58d96@collabora.com>
 <CAC1kPDMUUc3c7Ofyr7vXiW_Yt-kwrAOHK=9kQd5uCm2vv4h1gA@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAC1kPDMUUc3c7Ofyr7vXiW_Yt-kwrAOHK=9kQd5uCm2vv4h1gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 6/20/25 7:55 PM, Chen Linxuan wrote:
> On Fri, Jun 20, 2025 at 10:46 PM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 6/20/25 8:50 AM, Chen Linxuan wrote:
>>> When running `make kselftest`, the following compilation warning was encountered:
>>>
>>> mount-notify_test.c: In function ‘fanotify_rmdir’:
>>> mount-notify_test.c:490:17: warning: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
>>>   490 |                 chdir("/");
>>>       |                 ^~~~~~~~~~
>>>
>>> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
>>> ---
>>> Changes in v2:
>>> - Apply changes suggested by Shuah Khan
>>> - Link to v1: https://lore.kernel.org/all/20250610020758.2798787-2-chenlinxuan@uniontech.com/
>>> ---
>>>  .../filesystems/mount-notify/mount-notify_test.c  | 15 ++++++++++-----
>>>  .../mount-notify/mount-notify_test_ns.c           | 15 ++++++++++-----
>>>  2 files changed, 20 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
>>> index 5a3b0ace1a88c..f8e0c6b06e2d9 100644
>>> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
>>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
>>> @@ -458,12 +458,17 @@ TEST_F(fanotify, rmdir)
>>>       ASSERT_GE(ret, 0);
>>>
>>>       if (ret == 0) {
>>> -             chdir("/");
>>> -             unshare(CLONE_NEWNS);
>>> -             mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
>>> -             umount2("/a", MNT_DETACH);
>>> +             if (chdir("/"))
>> Please use the APIs provided by the kselftest_harness.h instead of checking
>> return types manually. For example:
>> use ASSERT_EQ(chdir("/", 0)).
> 
> Are you sure？We're in a forked sub process here.
ASSERT_* are macros. They can be used anywhere. Please give it a try.

> 
>>
>>> +                     exit(-1);
>>> +             if (unshare(CLONE_NEWNS))
>>> +                     exit(-1);
>>> +             if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
>>> +                     exit(-1);
>>> +             if (umount2("/a", MNT_DETACH))
>>> +                     exit(-1);
>>>               // This triggers a detach in the other namespace
>>> -             rmdir("/a");
>>> +             if (rmdir("/a"))
>>> +                     exit(-1);
>>>               exit(0);
>>>       }
>>>       wait(NULL);
>>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
>>> index d91946e69591a..d6a6a7ee87028 100644
>>> --- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
>>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
>>> @@ -486,12 +486,17 @@ TEST_F(fanotify, rmdir)
>>>       ASSERT_GE(ret, 0);
>>>
>>>       if (ret == 0) {
>>> -             chdir("/");
>>> -             unshare(CLONE_NEWNS);
>>> -             mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
>>> -             umount2("/a", MNT_DETACH);
>>> +             if (chdir("/"))
>>> +                     exit(-1);
>>> +             if (unshare(CLONE_NEWNS))
>>> +                     exit(-1);
>>> +             if (mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL))
>>> +                     exit(-1);
>>> +             if (umount2("/a", MNT_DETACH))
>>> +                     exit(-1);
>>>               // This triggers a detach in the other namespace
>>> -             rmdir("/a");
>>> +             if (rmdir("/a"))
>>> +                     exit(-1);
>>>               exit(0);
>>>       }
>>>       wait(NULL);
>>
>>
>>


