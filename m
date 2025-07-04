Return-Path: <linux-kselftest+bounces-36600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06088AF9AEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 20:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E0258685B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 18:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47701DE8A3;
	Fri,  4 Jul 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxVdEJlj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139181DE3B5
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Jul 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751655343; cv=none; b=Ph+fbiITtyNpRmDMLwQqlxm1nkVjAzA+ydG2rDy6xhTgbokfzW9E3/zqmxWH+pF+TJoXyrFWHJSt+k0WN45CjSBJiYfPQEMp+iBuKGTCPl67Y1n7QzSIxYJvdS9ONttGi7xy73u7KeJTN2/NQitBRIGkq2eDTfEIJfdDuhh15Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751655343; c=relaxed/simple;
	bh=i5UrnJioarzHLByYSLycjk6gxtQARLu2d2F8hbNdkaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtVAwbvLtXoMgaUVIiD88RDVjJQrKUzu4d+4AciOtw+/lBMs9fEXfUXL8EvdO+dQM1EYc/DthD2TqybM9KIjuPBZVWFuZbaeWF5Jc0S2w48m+xZU8X9dEke2npjPP5KO5KDqLseDsbxi7xZ8N2veuj0WYy+vVyI9xBAzL6NNqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mxVdEJlj; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e812c817de0so915803276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jul 2025 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751655341; x=1752260141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i5UrnJioarzHLByYSLycjk6gxtQARLu2d2F8hbNdkaQ=;
        b=mxVdEJljmD3oWeYcmSC6hY5ucxGQQeNi94/WSgMotvQXiqpBQHq0xqOiAWb+RmqnJh
         ygBvRKuIST5dEJcAjBABjh+SOXijS+yM8dFlJ2rnQWADCT6U6+Wwf1Of9TAdep5yMHjP
         5lbNZWccN3YaHxq37GNoSaCYWh1Q2fnUVmHufXerL5+yCRnS2xRVxfBYAId3qTj6qmcq
         TT+IKaHiNL1g4waxfmCCeJ62EEIr7ogYOHj/BTJdFX7n7RKs/ZgFPqLNgPT14gPN+9Zo
         tGkI6Z9sJPxcVMM5BmYUbibdTgUR8IIuWOYaVObnQJLtB0TjU8Jmm/aUX/7CeJ0NTXfc
         Zu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751655341; x=1752260141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5UrnJioarzHLByYSLycjk6gxtQARLu2d2F8hbNdkaQ=;
        b=NtbRsYPICr4sytPOM8IeyhSyMd6yiPzwGIdhqm67TfemHdDQeZyP/DUJoOB0xXVOw2
         Fnm+95lHt0TysoNfXkSikiM1pFhxR180/kFB2DxeqWI7bc6CWfAhu113DxBhP6477dgw
         zzfocFW3su17zjZzO+XeIxsdNb4aJlBpTrIAcIPkRW6hVG0jRteHVzJ/s4eOoyUbCxdH
         Ag7yDRB06ftIfH4vaDCYXjtHnobdRJEV79XttYOdSE80Eta+qVNMQX8+5p40tgt8j5Lt
         JlmYP/uRiC9PSyEidu9etw3hTz33OjN6zDakQKCZ6j4FJFn/ztRJtj8x87667dwFQIA8
         5zZg==
X-Forwarded-Encrypted: i=1; AJvYcCUNAMIUWt8UNPZCG2usaswypikM/vHGK5hW4XSkGDm2GngoEDekPXYcICFN9Qf13K9rYduAEFGOIlRs7c48LSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1TJG+6wSOIC3xDTG+1Xv8TMg292GaPyHOwy+ZlWXcdQ718Nh+
	EqLGWsJy3A9yLa5UDSTgnubYvuTy8LMTQO80mCRcYsIcRimHkpt+3q/YWo/feRyGlzckCsON41e
	iJr/efPyDCliN26BLZvzroodQOyP3FsKaETmHiaYOyQ==
X-Gm-Gg: ASbGnctbO3samp1PchMta2fMs3PSDo7mmcn9QELSXpaHKh2BE8+I1A4UezR5VtyreV8
	1xxrBiBpfdC9nOMuhOHM0xWKfg2I6GxXOBLFQ+67byBi6sTb4+ud55zjbqSt023ktBOhx8KpxfM
	ax2IVM9SgwoRhKdoCyzjGRSb0enOSdOWDMCW9HHNQe3Mo=
X-Google-Smtp-Source: AGHT+IE8YU8yP6esqnqUnZk9RLXSToml0bj4v9nH7DrJYcsEUr7XQwY4dJ3lhgYdPf76EoZr+KTAoSLIcBsb+9QtwDA=
X-Received: by 2002:a05:690c:d0b:b0:70d:f338:8333 with SMTP id
 00721157ae682-7166b6cdd09mr39558687b3.22.1751655341084; Fri, 04 Jul 2025
 11:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704103521.10124-1-terry.tritton@linaro.org> <61f90ebf-3cb4-4e81-a7d7-cfffe41d9d47@igalia.com>
In-Reply-To: <61f90ebf-3cb4-4e81-a7d7-cfffe41d9d47@igalia.com>
From: Terry Tritton <terry.tritton@linaro.org>
Date: Fri, 4 Jul 2025 19:55:30 +0100
X-Gm-Features: Ac12FXzsS18VRi1-qE0dpcrfnADu66E0lCMTJzxKRd3EQs1pCzZ2Ghi0HmE4GGM
Message-ID: <CABeuJB1QxwBHn+_6cZP9WJXG+gh1x5HWYW9CGVEajqHL6GSEbQ@mail.gmail.com>
Subject: Re: [PATCH v4] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: ttritton@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, linux-kselftest@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org, 
	Wei Gao <wegao@suse.com>, Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> However, please check the results ./scripts/checkpatch.pl, there are a
> lot of codestyle errors:

Whoops! Can't believe I forgot to run check patch!
Thanks for letting me know.

