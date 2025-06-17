Return-Path: <linux-kselftest+bounces-35180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DEAADC386
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE109172F94
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79028D8EF;
	Tue, 17 Jun 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZAFvrA8H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A7D28DB52
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145916; cv=none; b=IHeaBKUiLffz6bhE0io9Ua2qiBad7RWbUD0RgUOHUih0hquEGArBMiLkUYLkOcsisbGDcfs6u1BcTFAMw/KptK6eUcglCcabdPFi8RqdGAsg90FUlkkfRkuSYTcOZs5fCGcaWk+srizNck7/liW/cjzO+9TAWlVloArkpqcU+uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145916; c=relaxed/simple;
	bh=8hre+ioZSV1ApKk0mMHgtp6YNV3r2Lv8bwiGE/XHevY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WE2Jetfnk6OwbPQqakrWtiQ2L8rq/b0b4gxOlO5Bx56Rya5qk59zDmNHODvyV9xXJK447elVOvg9NaCnrLZY/tW2iVH1d6xQ360MWOZ+q9YAqDMxgk3kO1ugo/TYtnl0m3q+GP1H9Vrdk0QwOxO9kPMidazGkuJy8qqdxyZP/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZAFvrA8H; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a588da60dfso218625f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750145912; x=1750750712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06WdrqrgwMt+XD3JlxWH3rD2dWkzuQMHj217UXJd1mk=;
        b=ZAFvrA8HheWATGw+r3/dK2tdOyWQDuFedteaxpkni/rcBlxdgd++CPXH7Y6nZMf0wd
         wkD9L15kea2H0sxy9YfJmNw0IMpfhw9smRFsAGj1MNsvAXkuGyP6ty/wsRtJg/tlSKy+
         3Tk8kfRzFoiHNFaaYeh0YSQ7S5yNkgMH64aMYFs7qkVym4l1SWFhKN9Tq4c9SSnH8eqY
         U46FWVAw3ihWfZbSTVW6DJdBaSH2o0K5bVQggXvqBxYju2NiXi/x7x/3hZL1j/uUTk6A
         AvrvFlr5rtRiipI+138Afw9eu2izvgYuZUrADc3SEMaa4qZv0qIRpoy3ow7DFAVZkKTv
         OZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750145912; x=1750750712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06WdrqrgwMt+XD3JlxWH3rD2dWkzuQMHj217UXJd1mk=;
        b=hbqo2r2GWIUPuUQZKKpkf7ip118Bh3SKblLt6N18QZGfuYORCsYSCEzkRBa+z6LmM1
         gfFF0H9bhJ7ebJ/harVnY4ZIoFCEKTZIFix2w4SfXnzMTFxcT43rrB1dMXBt9D2+4PWF
         H5uswO7HdxbAAU7SLAOlvjE5xyOBSQK+GiQqxkOdoXQs0mJ5udqikURUxwJssmVbiObK
         KcFPf9GywSJnQC6ilGmeEdMlYQ747n/iuakvQQCjcyDaMPQJDmTh1WLEMsX8xx5rCJj3
         PBhCnJZwUWrx66uLz67sgHICsEmUE/r5s8I+pcZSstd42YcL5O3MNW4A5EAlftVj/ENJ
         g/HA==
X-Forwarded-Encrypted: i=1; AJvYcCU939NSLEqBx814x/tkREBTbhibl5CzYfbYmv86jXxZttAaZYslm82a1YvBZ09pVDt7UOYYEKOIE4/XK48aNcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGQjHrw9CmtGeHXMFQ8ltY8AnVqyH5bfZN/QRuJd/wedroHep
	QVPPbzfSxzhOzGnw++DqwNKGNhyUyu4ANIF+FZpMqKHH8D15mGgkAPDh//umAYELovs=
X-Gm-Gg: ASbGncsYtmAyCQH+TO1uS9cnmOutrZx9EEQjmaO65NkHYY1g2JrkD/2d9y73MIBRFnA
	HR6hMf8bBkbUlJhCX73wAEsIULOdnjQvrqXaBPkcyEfL2nUa3zJUjlrtirz3F+cL/GAY/oDWU7j
	UoCrWfcHdjQm75oscvaZaRFKUKOCjLv1O/sotx4/FPxm/qF98Fhsx+qugF9hCmwcyc9sq1rXkDi
	3iPP5nPiZxDihQjfPwEeSTveYwmhpsFAlb8wz67he0QphejF896DmJLApaOipc6VHYtELZsrDH2
	Q1O7NaDtlD+ZgzSUBiVeldboomWJ4qcMCXycDrlXxwaw1E4FWZm93WwXCMFHckurbTd+THMLYBy
	Q
X-Google-Smtp-Source: AGHT+IEsDXzygzUiu5hDuvAS7nNYSt4nrUBrznqidImzQhFxIgxXYCsglRc9gafDTyPOPS+m5grryw==
X-Received: by 2002:a05:6000:1ac8:b0:3a5:2653:734d with SMTP id ffacd0b85a97d-3a572e7a1eemr9910886f8f.28.1750145912511;
        Tue, 17 Jun 2025 00:38:32 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e1838fasm164856835e9.38.2025.06.17.00.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 00:38:32 -0700 (PDT)
Message-ID: <87e3de90-ffa8-40b7-a81b-70f5e5b8af20@suse.com>
Date: Tue, 17 Jun 2025 09:38:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] module: move 'struct module_use' to internal.h
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-1-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250612-kunit-ifdef-modules-v1-1-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 4:53 PM, Thomas Weißschuh wrote:
> The struct was moved to the public header file in
> commit c8e21ced08b3 ("module: fix kdb's illicit use of struct module_use.").
> Back then the structure was used outside of the module core.
> Nowadays this is not true anymore, so the structure can be made internal.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

