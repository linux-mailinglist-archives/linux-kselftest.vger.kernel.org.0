Return-Path: <linux-kselftest+bounces-46929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048AFC9DCAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 06:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EFD3A6B32
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7302274B32;
	Wed,  3 Dec 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyMhIH3H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD361A285
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764739244; cv=none; b=l0y4GpIV7wDU+DCdl/KYDjMxzu/txaKoU+6xlO7qYkybBbGrJZ2z8bI7g7aGp9YpdObAv3j/F76wz/f12gNlOTuGEeHA32m0/2U4wCyUrdmz0hrl7P/QLYFaLS02lKG6SIiFrh5ZivwNt4GFBSIYJHAKVeY75XVzRtLOrbUzGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764739244; c=relaxed/simple;
	bh=KnwIDdcXunqaoPgZQredHZwy4TkDSumVaNxjL6+L2lI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gNVP7HlIqwV2JKSdUp5S6NJ1VK5LttpkaOYC0nwY+oBtIcXWq88gOskFEtLLrLZxDqqDV0HmJ+hO5Of5OZj5T3Yrxd04/Y2Zh6zcx++sUzCePpYumXOSgFUw7D8jsM4+V0wUkJGw5dpYG4cjfKdagbcIZvQFWn5nR5vyfYIJnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyMhIH3H; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b98983baeacso3004975a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 21:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764739242; x=1765344042; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KnwIDdcXunqaoPgZQredHZwy4TkDSumVaNxjL6+L2lI=;
        b=WyMhIH3H9vIQTdYsLfpWwg7mtcsMAGSUXeiLxgr91yt3+0xhNTYHYJYxO2J0cOhVMW
         YjZ10O+YehSiusOWWnXs0U2Jvs4mhwlC6aaXxYqm7igTNkYCxJc0el4fYc06ImT6669q
         /sXwt2U1oubH9UBIDbuRIf34J59dx1HqnSBnoH5rAiucwoemu4IFmdSYt/N4pKuC6iLz
         jNTToswQ/cVavxKZPfBi6VDd7h8xCq/vLIQtfL2cbsxs+p5U8q7cq8tS6MlS3yHuzodT
         EM8rj0TawBwdNsUq6GhKr5hFhNg9AJyz2aBVuqbVUk77PTfBTAwcId9xuP99Lie2AYty
         a97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764739242; x=1765344042;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnwIDdcXunqaoPgZQredHZwy4TkDSumVaNxjL6+L2lI=;
        b=Nj/8knfqTNEVgH7xjM0XRyA3o3XoKNfK8IBEmQ0iO6PpHa5hajoEi+w6BwnPj99jNi
         Idgawey8Yg80DWD8I3AL2CD81WshURAevemvCoy+dkuOMX5pVqQLqckZ8uR7Nx55NW5n
         sjFIOhJu54cIaqByrRDmXfvy9JUp1QIkzuZLDM6fMNzhla0kj1oOM+DJC0BLYe8a4hE/
         eOW4hNHA+tp5UzTNAmDGV2B5LvFTeD6VSVTgU249ICTDO1Veh5oJ3FH9ts4gAD1d6my7
         4JEECQC4FGWEL/qZKdNzCfK//DW+gWiVMOKhySBpMbynebuDiP/nGCaRUuMig31CIdF/
         WbUg==
X-Gm-Message-State: AOJu0Yzv9BSjtkorwFxqP52x5eFB+0ukLH0/xj57jR8KqqYguBVrTcpx
	GnTWwismsyYxqP8JKyEjulbo9360O7/l4OZ8hZT3hLHL7cSBJMLwQ+SH9pP51g==
X-Gm-Gg: ASbGncuRThvmwbYHUM+YFeta0H+BiPPTg+YmZ/SbM0gcuW0vU09eZyYG4rVAJmZEXwS
	ed3PmLhs0hQeksMAsPS/GsnRZAqZOQKRcZuYQfEpJot9BHGrtnlY5eAVVpCa6ItdF6mO2AHmc8n
	TJskqwxXTkEJMx1UCvX4ECz2fIul+yyTD7yUAE9LdDh2UEooEAPc+gAF/tb2MdEEtqo1KTBBFnh
	zZoXASbAesUMZKt8PT/WZgFU/Nl/KdliJPm/WdgUWvJOl8vABA/0of6wA/cMKpKXKAYZI+0CvFC
	NKr+bQK2N68cOB/qY3ZsolxvylMDsDSUJ/rIdqO83FsWbjrVIa3xJqWzh1z3NgJl3yzxegl54c8
	5iyjIZxhjP70jSRO25pR/+wryHh4pVpq8XwDAxLt0iQ8Jl1jfsG2agi7H58ii7xk6cO+8ys13JN
	/aYj98foZjyE2yDaC/NO6vw7Q8JuWjc5fSOp6uqTKJkJJZWPUz2SaAge4hoAE=
X-Google-Smtp-Source: AGHT+IGkVmPam72WvRuNDcgiJMXqmVLwjRz2h+n1Dvg9oQ0O0lfA4kU93aNlZZRsYLTwsB/rURFpBg==
X-Received: by 2002:a05:7300:f590:b0:2a4:5c3b:e2bc with SMTP id 5a478bee46e88-2ab92e20626mr630770eec.19.1764739241936;
        Tue, 02 Dec 2025 21:20:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a96560986csm92218769eec.2.2025.12.02.21.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 21:20:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <44e08e2f-7f22-4106-b581-56150cafb048@roeck-us.net>
Date: Tue, 2 Dec 2025 21:20:40 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Problems when trying to build tools/testing/selftests
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

when trying to build tools/testing/selftests, I get a lot of warnings such as

mount-notify_test.c: In function ‘fanotify_fsmount’:
mount-notify_test.c:360:14: warning: implicit declaration of function ‘fsopen’; did you mean ‘fdopen’?

and subsequent build errors.

testing/selftests/filesystems/mount-notify/mount-notify_test.c:360: undefined reference to `fsopen'
/usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:363: undefined reference to `fsconfig'
/usr/bin/ld:tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:366: undefined reference to `fsmount'
/usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:371: undefined reference to `move_mount'

This does not just affect a single file, but several of them.

What am I missing ? Is there some magic needed to build the selftests ?

Thanks,
Guenter


