Return-Path: <linux-kselftest+bounces-15067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA994CF55
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 13:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5691B21D6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664981922EA;
	Fri,  9 Aug 2024 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKJqLkxQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90354191F6E
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202621; cv=none; b=NBBuCGgEIpfo0xHUWmtRiFCPZWzXgm/Fw26HXknHR1pU+MCddLRwHfrghPq2aQQvNe9LdMLusGHh4zDuFC5H17DAMW+is830UYlhQUA49SrJkjBAgthHguGVUHVva61e1ZCCefSAWyyRCHvNl1MHW4Ox8BOCxG12KEXthfj4AVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202621; c=relaxed/simple;
	bh=QANPEf7LLU2B4HYlKyrQ5YUka9pHT0cAe8+x4fTubZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gj+6x9R8/7VdQVbC0Xgo602PZWz9beF3G2Ffe08qaaHQSJ34TGVlLpsRDix7YHc9BC4k2HlSVWJtiNytv2RzNB1DXOvsqo6EleEnGffiWc+z6VSjyNukcrkVe4COVQY94GiJZb6Gf3N7DhLvvUVSNEc+X3YZ7/GxQktxbbx2k3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GKJqLkxQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so2170976a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723202618; x=1723807418; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gIB+mAZwc9hjhBiqO7I9QcAHm3Z+LjN8ywxSscGS2M=;
        b=GKJqLkxQHeiNvO3fSZipNdzByV6ToLxLdDSu2EKUZ4TEq2oAtBMPtKdjG9crokO1lS
         G9upOj4CDNDBzazDWwpnCHMp1nwTcHm4Ha37JwqPDg5aLUwZPMCymOlHi/aPWdM8eoDA
         REUJRXyymoQ9KLvLQr59NSDRtEA7TYiAezczZmTM4D3tFi6rvUM3VN1LwvjZ5V2SwkJe
         h13ZvqzcKmE+ZB4dSRCz8jdvEJ7dTSaytdRyn7hhHNnwKfmdqeck2JgAt+hRKahLhlbs
         jyeKjMrl2mp2pQtG5kSjieT2NALYW25MhsEzHl7AwFT6ZQyL+HRwnW0TYC3vff4yhm0v
         yjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202618; x=1723807418;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gIB+mAZwc9hjhBiqO7I9QcAHm3Z+LjN8ywxSscGS2M=;
        b=vyUYKSpWD+fJSYL/7u2Bxd7hhzAmu/4v2fcJaQQF2sUWOtAXvfCGcjWt9n3rFc1RlY
         OE8E3+6o6kISS071KCHP/D0/gUfE94iMOOP+TLaHi+cT9awAG53MjNWBI12rbDNA5ngG
         3cOs9FkcLdHmZ7f4hCJ/ozLyF5M46Mh94FTbVRXoLVX2IenRlnBWFN1NAN+Vm1U60ICj
         BGPT9Pr808eMnQyp1OvhVLOTY4j5vu1h/mPoqpROAHFj4aGk6ktDExYQLg8IK4yEB8YJ
         xmjq8g8TaF2V4P6tbfxfyMCWNyGjZDhqAdILAG8SsbjZXuP9qkjLV16uv9YO5jJQ5N1i
         66NQ==
X-Gm-Message-State: AOJu0YyG29QTu6PWkZg3R+aQkarc8jsciUalAbr8iqBQOad7Jzk5/MjR
	qj95U2j4EWjFx+KkBQg1qaZIHY+jfEWUdH8eHVGpzBLnzRSM7DxwISknIiXNCGKVB3BNoo7fVnK
	m
X-Google-Smtp-Source: AGHT+IEykp6tHft1bvRAq40l+1B8AJ1f6n5BI2WPQC2TZfg9EPYsflAno/J8fk0+QRmoJ5dq5joK9Q==
X-Received: by 2002:a05:6402:5112:b0:5a1:a469:4d9b with SMTP id 4fb4d7f45d1cf-5bd0a58d40emr889300a12.13.1723202617785;
        Fri, 09 Aug 2024 04:23:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf841asm1433293a12.5.2024.08.09.04.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:23:37 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:23:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/bpf: BPF register range bounds tester
Message-ID: <5988b755-125a-4288-9f39-f34b1bab6e63@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Andrii Nakryiko,

This is a semi-automatic email about new static checker warnings.

Commit 8863238993e2 ("selftests/bpf: BPF register range bounds
tester") from Nov 11, 2023, leads to the following Smatch complaint:

    ./tools/testing/selftests/bpf/prog_tests/reg_bounds.c:1121 parse_reg_state()
    warn: variable dereferenced before check 'p' (see line 1119)

./tools/testing/selftests/bpf/prog_tests/reg_bounds.c
  1118			p = strpbrk(p, ",)");
  1119			if (*p == ')')
  1120				break;
  1121			if (p)

Was this NULL check supposed to be checking for the NUL terminator?

  1122				p++;
  1123		}

regards,
dan carpenter

