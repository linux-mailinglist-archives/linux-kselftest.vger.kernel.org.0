Return-Path: <linux-kselftest+bounces-44716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C0C30C82
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 316AE4E4EC5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE52E9EA0;
	Tue,  4 Nov 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+dSonTa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03C2E8B97
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256440; cv=none; b=Mh4UiNjEBMk5IzPdzju+N1aoW0BEUoxP8vLyTNyU87qKBrPMqj3zG1moLUXKXpJxod2g5cgUBs6fmzb0F4nWF22jTMTmaBmZju4DHPFxpFzLutsqF6k0Qm7xho8SojlABdPv02k7mq+cw/niV+YSdVRTbU4vFETJ5Aw27C6p5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256440; c=relaxed/simple;
	bh=+oWB3A/Q6CzSkeY4soYqa5X1mb+HtRxJLp8w5G8pEck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWfHDpcGjbsgyxSIgbUkaLu2mn/fwhvauEawfM0+Gv27Wy+AGQWDbht//8iM26iA3mZUqEOnRoWdyScJY3X4bdvMlFRu7iK2vt2CN1bVUr4LA/qIAKLjhhswFHYGSOiUKkCDidZA9NlioLppu62urEyk+jyGciuYbacLn0KxBMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+dSonTa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so43938515e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 03:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762256437; x=1762861237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtEDtvTY+cIWIGM0pelvhRwZ4E8HNdVkiBIKwKLkzCw=;
        b=l+dSonTacJJFCdYpcvYCqnsSTvVMQ1qkpeWJcJoHLX+HhLJvE+s7UXxtgr968X01o3
         d6zvdb5YMp4tUNUymW+zwuri9WD4A12uTunHXOTNLowE6mVhxRsd7VSZXIahEzE8jm2F
         INkISQwNl5Kh3ANOLp1jcwDaJvTLOFkTFk3ZqpKGyAoOYKe0c74h9G1Cy39qcvajAS+D
         QJKNU5fwHev/q2AYgX67XFfXlTsGOCeLyaWKb8oRyptKY4AJJbyuR0JLYUJAlE7EPe/e
         Z0WE/2hqQasv+MZ2tnu6WnIJgbRh5c66O81Y+iEZ3GVmdu3Lqbdf65iKBtpHfnCrwarV
         IxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762256437; x=1762861237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtEDtvTY+cIWIGM0pelvhRwZ4E8HNdVkiBIKwKLkzCw=;
        b=OJNDAxXl1cR3v0kLKSv0lVeJ4HZLyWsPdcz9mCtaOsZ4WFTXocegozghhY+xYrvJdF
         TodovU7na+oplq7g6UOmrL8qutzGiYojEmwQHPwRXCpIP2BCXHsbpl7q9PFkGpew2Ba/
         lrumTRtQhkaQ26AmiXoaEGOpGDu9H4frYQrDAo0ChHZ4J7pcmojH6ykVVJyIX3R//AAl
         BKaXLN6w0xz79+M6LOaZmn+tizj4nmaLBtU8NDlnoKCeyTp36V+m1UwZ4gDNav2E3BvW
         3RO0lXRrSCScCZxyOvLXv1OjibkQEGkJ9paah0SrqzsbGSShm/G8G53VaTbrGOnxQYmJ
         LbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFvPOXdRU7gYrKVLdFGfKevep0eweJZYMvX57C67PMPgxigT0mjZuMPZo5iy0A01fDOgP80/bUJPGbhaGS5WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbhRun0ant94Qzflpgu2iAi2PRxPwONF9RQ+sk8nUmGboVLd1G
	jcFSdnEhQJkcEEw3HGbrxYSxP3AWMLiwAOGWaxii/sx0ZhjlYziR1+gr
X-Gm-Gg: ASbGncsaNsc/OKqwdZfEEFMH8orEY3sjxzuZkUhILy47r4AjYvXizV2ZhuW/x6fmluq
	n1ndpBZS1Dy41JPL17vuBJvcK8qAuV+x0NduzDecbHexSJkpurn5RsSo3h2c5qtRS0Y5EC/b50l
	3oE4+0iSbRq+0EFOpWW3hhTYk3c/EjdzC4PsPZQ3eEVu5xnwCSFWZhZfcfQuIzi3+JN6A1fXZbi
	QNZ8jk0PU/E2pUo8irCJB1haOJ4aE/gAK4QysdR+bvgl11UVPaFETz5eKu+xxkT+GLH28VzzoRc
	AQrWF9xmFbBT6BEVFTj56IbbE4SEV07XQN6Tmq/nAH00CUp1IWj8g3bt2LKixqYyuSfVHjzhEWZ
	mAw1QUmr0Frxt+dvxrduWtV8KDQKcNzO7Bm4mtwpn3N+F4ob+NQm+hJzwtBKEZr46PRbFGasP9X
	EmJQ2MooprU3PG8nvKHn5GuIWHjg==
X-Google-Smtp-Source: AGHT+IHLUzkgy93j93/Y457i3JDPVA/x2jz7pwHQeQNMkgQOo5iNeUyTYKEKqioqrc6ql8RXud3YDA==
X-Received: by 2002:a05:600c:3146:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-47730802c68mr141327745e9.13.1762256436466;
        Tue, 04 Nov 2025 03:40:36 -0800 (PST)
Received: from [10.24.66.43] ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755a550dfsm33200985e9.17.2025.11.04.03.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:40:36 -0800 (PST)
Message-ID: <0c3db907-7012-43c3-b7fc-36848789da52@gmail.com>
Date: Tue, 4 Nov 2025 11:40:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
To: Sean Christopherson <seanjc@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 isaku.yamahata@intel.com, roypat@amazon.co.uk, kalyazin@amazon.co.uk,
 jackabt@amazon.com
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
 <20251013151502.6679-3-jackabt.amazon@gmail.com>
 <aPpi1c-8EpWuo87B@google.com>
 <c52db7bf-494f-49a8-9829-3805db6dda7c@gmail.com>
 <aQkZtjLt6lIULffA@google.com>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <aQkZtjLt6lIULffA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2025 9:08 pm, Sean Christopherson wrote:
> On Tue, Oct 28, 2025, Jack Thomson wrote:
>>
>>
>> On 23/10/2025 6:16 pm, Sean Christopherson wrote:
>>> On Mon, Oct 13, 2025, Jack Thomson wrote:
>>>> From: Jack Thomson <jackabt@amazon.com>
>>>>
>>>> When creating a VM using mmap with huge pages, and the memory amount does
>>>> not align with the underlying page size. The stored mmap_size value does
>>>> not account for the fact that mmap will automatically align the length
>>>> to a multiple of the underlying page size. During the teardown of the
>>>> test, munmap is used. However, munmap requires the length to be a
>>>> multiple of the underlying page size.
>>>
>>> What happens when selftests use the wrong map_size?  E.g. is munmap() silently
>>> failing?  If so, then I should probably take this particular patch through
>>> kvm-x86/gmem, otherwise it means we'll start getting asserts due to:
>>>
>>>     3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")
>>>
>>> If munmap() isn't failing, then that begs the question of what this patch is
>>> actually doing :-)
>>>
>>
>> Hi Sean, sorry I completely missed your reply.
>>
>> Yeah currently with a misaligned map_size it causes munmap() to fail, I
>> noticed when tested with different backings.
> 
> Exactly which tests fail?  I ask because I'm not sure we want to fix this by
> having vm_mem_add() paper over test issues (I vaguely recall looking at this in
> the past, but I can't find or recall the details).

The test failures happened with pre_faulting tests after adding the
option to change the backing page size [1]. If you'd prefer to
have the test handle with this I'll update there instead.

[1]
https://lore.kernel.org/all/20251013151502.6679-5-jackabt.amazon@gmail.com

-- 
Thanks,
Jack

