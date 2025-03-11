Return-Path: <linux-kselftest+bounces-28749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D661A5C29E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547B57A8E89
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278691BD517;
	Tue, 11 Mar 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MpKbnLeS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03878F47
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699699; cv=none; b=qZOFGI8PKZ7erdnW3CngntMsVwNKLiFvvQyTiiETlvbk5owHHP85Wtzg9M99Yr0qVU3Xb3zpdenlYj+mejf4cTi+JtAUjemPChhW9+FC42k0bBqU1Z+vn72sOZiB4PHnosUJa+L3r9saWGthiCVtfh9k6/s/thAkrw5c+7aDpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699699; c=relaxed/simple;
	bh=8by/GpPmqkVACM2ONGL1pBGZdfM4i23E95LC6lf9vOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfGchD8KjT3Bl2F8NnLqG5aJ0CuG+vX199TrX4wWn12QXR0DE9Cxs2LG9YQf6ltt5gwPwVyIlypb/l2pD8/zoUSGSB1i+JQj9fpe3gS6VHdJsUdQnFo8oVFYOjavTrHoznAEr8L6BlZ1opB7+GWD8q17nyDKNR6uCjvcGJzoYsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MpKbnLeS; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-855184b6473so370580539f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741699695; x=1742304495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXEFQQJ7zeYMoU7AeoXlfPbZ3jDP+PoYlgP38jKDBC0=;
        b=MpKbnLeSlyGkXAIN6tpQSIPZ37FJLRmVwmx+81uNp8K6jUK4FAKlUuBHyPlzVE/1Bm
         bJj3taAngxOqJf5MXLoNu0HL+1bw/QvbAONh4jyra7hWnFhu0b2YrrACh7sCTcMP/1z3
         7+4fMrE1kf5rYLTjiXj6Z4za27eOO86tE0lvqkPg8TzRG0l/YExW9jS5uj/NptpDIvkN
         uyAAQusoEVqNu//p7lCz5n4fWM+SRAnLV0dCk7KI3rnWbnEw27/UcitjnQMPFP8Mbkn/
         tfp3aQLdJJ5NXT7VhoTFwpvkPhu9TD3BzBnpRzaoWbt0pAdV/iSc21STMu2tH1NkvFYs
         TUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699695; x=1742304495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXEFQQJ7zeYMoU7AeoXlfPbZ3jDP+PoYlgP38jKDBC0=;
        b=S71sh6kcPCDtL65q6ZjCPYtI6Z21PW/J6LZIFZOnHgUJ5AAoCnIhXPb3cLiMY+aGIf
         b6fvsYto7wiEABNEpchCmZHOBmagujnu0W15pk3p1h0CAxCWgbICaRbaHXeSLQBIIbqU
         6GeMOStUSuwoAvDlSMUlpMBhUnIo2otKKT6jN5x/g5RakOWejWgZaoXJOSWL6QooJus8
         mu3ZYhJ04IBivIiXoCfgAUidEEydnsL5RzG8tnKo0jO6vkoq7D+Ai44GlGfNfBjEPoPt
         zBiP2W/j9Ia/744bye3dK6YwLyhI2l9p0VYq2Hwl//EVLp002psdicwTg8TmviMI16Gy
         hodw==
X-Forwarded-Encrypted: i=1; AJvYcCXpzDrUhDCFwkItRBpdBGECtlfw6jM++VqAEggOy7AZ7zjLg2OnhheEFOetw1rXmdl8e3nL0D20iktXCMcpzjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXd5uHRRVEjwaldJezJFFnK2xlzziqyxVrt3FmPR6Lgfnxuu4O
	jG/hHBFDZ080HYIgOEV8K7tEx8RYJZ03ip+HSUt16Nk7cOnY5Bis12sVO633DKE=
X-Gm-Gg: ASbGncs6LwSBOjwyp4RN61mT4LeZFEejmKEJh38h/mN6zGymSz9pqHbY+KnpFVz85at
	QfI0TlPDo/zjKDPu8zciv+893dnRHx7c5r4MGUa9SCUTZNT5lNqmIlTe7GNFpaXvvx+1yHiFvTM
	wggSxRZbU8gR15hVdI2Rbh5CRsP0HI7x1KH3re75Zy6imstQppQ2cRCL01my4+hgRWt3nbpu3RB
	oOiH8LZL6BkV5S4eWOaqLSHQMiEt5UTkv5cWo8E00sk8EWicWvx4LR7Nf7eGwqMtK/B5G8ZTnuI
	a3V4Dj7O1Rf8RvKoYF3MxZBvij0kUbyBiSbsg6Jr
X-Google-Smtp-Source: AGHT+IH8g/MWtsEGvdQDmf4GC0P079fOIy5/X4ZdSrnNoGSmHl1UNalVJ/0gbpRy/D8YS0vTKtYEgg==
X-Received: by 2002:a05:6602:80b:b0:85d:9a7a:8169 with SMTP id ca18e2360f4ac-85d9a7a81b6mr260189939f.0.1741699695196;
        Tue, 11 Mar 2025 06:28:15 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85b41cf5695sm106369139f.6.2025.03.11.06.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:28:14 -0700 (PDT)
Message-ID: <8f4d1ea4-51b9-4ccf-8159-2e31732c7f81@kernel.dk>
Date: Tue, 11 Mar 2025 07:28:13 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250303124324.3563605-1-ming.lei@redhat.com>
 <CAFj5m9+25+zUjUun12YvEzcH7NZ4eeJrq=p+7DYZ7kuasiDoqw@mail.gmail.com>
 <95955f2d-6bcd-492b-9057-37363168bdf5@kernel.dk> <Z8-9jmZ4jiA7C9gI@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z8-9jmZ4jiA7C9gI@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 10:35 PM, Ming Lei wrote:
> On Mon, Mar 10, 2025 at 09:17:56AM -0600, Jens Axboe wrote:
>> On 3/10/25 9:09 AM, Ming Lei wrote:
>>> On Mon, Mar 3, 2025 at 8:43?PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>
>>>> Hello Jens and guys,
>>>>
>>>> This patchset fixes several issues(1, 2, 4) and consolidate & improve
>>>> the tests in the following ways:
>>>>
>>>> - support shellcheck and fixes all warning
>>>>
>>>> - misc cleanup
>>>>
>>>> - improve cleanup code path(module load/unload, cleanup temp files)
>>>>
>>>> - help to reuse the same test source code and scripts for other
>>>>   projects(liburing[1], blktest, ...)
>>>>
>>>> - add two stress tests for covering IO workloads vs. removing device &
>>>> killing ublk server, given buffer lifetime is one big thing for ublk-zc
>>>>
>>>>
>>>> [1] https://github.com/ming1/liburing/commits/ublk-zc
>>>>
>>>> - just need one line change for overriding skip_code, libring uses 77 and
>>>>   kselftests takes 4
>>>
>>> Hi Jens,
>>>
>>> Can you merge this patchset if you are fine?
>>
>> Yep sorry, was pondering how best to get it staged. Should go into
>> block, but depends on the other bits that I staged for io_uring. So I'll
>> just put it there, not a big deal.
> 
> Thanks for pulling it in!
> 
> BTW, the test behavior depends on block too, otherwise it may fail
> because ublk zc actually depends on the fix of "ublk: complete command
> synchronously on error".
> 
> So if anyone wants to try the test, please do it against next tree.

Indeed - not a huge deal, as they will go into the main tree at roughly
the same time anyway. But good to note.

-- 
Jens Axboe

