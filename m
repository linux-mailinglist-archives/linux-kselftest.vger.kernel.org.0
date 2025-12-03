Return-Path: <linux-kselftest+bounces-46951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84973CA0AFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 18:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA4D93000B21
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D0301460;
	Wed,  3 Dec 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cyLnQYbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5533D6E7
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784555; cv=none; b=s0c0uNGyZ6MQYvrNS2BGIseVegtwCj3UE4NMcOAl2xRhLTcKExufrl2bU/PZARNLgt4pyAX6WNtUTyrV3MHgxdt0zaEKj1J4SDj9Z8bA9gCN7LUYQEFjsxoL4norVtKMW/CJSbyTl2fT8dDzXBrLYfFakdpivX8b6zt2CDLxnio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784555; c=relaxed/simple;
	bh=Dr7RVSChi264JkWMxljiajI/KNWq3tCHcnXKxd7kvC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dH2xmXIY+0wSx13xqUbOdvlbuuxr3vY0mUTecyYqePPngX0ASGP/SS4o2kRUtXSmOIlNVcO6EzGTKRQaxw4VWZXNt0TtMhAIgG0N+PKeCeJSrE9Pnuh3S+dTyaGZIMDIxYgAkkrzOZTvlSRLhe1AmH5ArjDSjA8bPH0Y6ZHLN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cyLnQYbJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=fr2EenPbT7TXJb49mjpOSUZdfls6BWCvS5ammf3zUkY=; b=cyLnQYbJRUYOic3uyOm6p3FalE
	IRtTtupN1FQzLSQxssZHo6/2W34XBwXiOCXGLmKg0HGzNBn4uVAELQoowc3tko5IvwS7HaXKPFMGf
	mA8qLkjfHWMfrGl/n5wFGpwR7H+SfPsWQfS3869Oc4TcN1dJUfilN8g/jYcnw/ShurNH4MIPh6jv3
	QM2kCTa9Sjli+DyZPCOLUQWdtJ8igpScLzeDXf3vM2rBui5w49BFDaHKIv2OsCRCNtuVgH4xZUpW/
	+/DhRuHgvf6Ot4xQhJIHOk190l8+4n2wVwiUJuaFL5pbtIm7lfCP9Piv2WS8fktnUaMj48k8saPcX
	aA/kHTzQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQr4y-00000006tF6-0i8D;
	Wed, 03 Dec 2025 17:55:52 +0000
Message-ID: <d64e84ca-8a3a-4ddd-bbef-feebb17ff283@infradead.org>
Date: Wed, 3 Dec 2025 09:55:51 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems when trying to build tools/testing/selftests
To: Shuah <shuah@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <44e08e2f-7f22-4106-b581-56150cafb048@roeck-us.net>
 <bb2426dd-3c29-4c94-ac77-aaa0b422b2e7@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <bb2426dd-3c29-4c94-ac77-aaa0b422b2e7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/3/25 9:25 AM, Shuah wrote:
> On 12/2/25 22:20, Guenter Roeck wrote:
>> Hi,
>>
>> when trying to build tools/testing/selftests, I get a lot of warnings such as
>>
>> mount-notify_test.c: In function ‘fanotify_fsmount’:
>> mount-notify_test.c:360:14: warning: implicit declaration of function ‘fsopen’; did you mean ‘fdopen’?
>>
>> and subsequent build errors.
>>
>> testing/selftests/filesystems/mount-notify/mount-notify_test.c:360: undefined reference to `fsopen'
>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:363: undefined reference to `fsconfig'
>> /usr/bin/ld:tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:366: undefined reference to `fsmount'
>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:371: undefined reference to `move_mount'
>>
>> This does not just affect a single file, but several of them.
>>
>> What am I missing ? Is there some magic needed to build the selftests ?
> 
> Not sure. It built fine for me on Linux 6.18 latest. Are you missing
> a library possibly?

Guenter, did you follow Documentation/dev-tools/kselftest.rst?

Shuah, is that document what you recommend?

-- 
~Randy


