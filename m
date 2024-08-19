Return-Path: <linux-kselftest+bounces-15684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CD95741C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6FC1C23F49
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38951D54DF;
	Mon, 19 Aug 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtF2A3RF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18151D54DA
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094370; cv=none; b=mXnNm5r0EUUGO278KEpvQBZQnTZrG9rhdOlteDnKAgtpXhT8Kws9nH2OafXNhAqpnYY+LKfWrvQMSAyyzbpmYqNynbHw/Gfp3cmFbMUoKg2asRNCJEfomuRV3kqe8dQIfh9fgHBTtz8nZMap+gRTuUxfC1fNbRSW6h5pQJDWf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094370; c=relaxed/simple;
	bh=x6GnFcqfLriMSUYlFosyi4vREQXK0AxVjX74gMTIg+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eT2HgtSw8ce7Leg4vnHmMQzgLfz8KQ0qArvhq9oei7OWJ6Vct5Wo1YIG2UcSNzMHLN/9+h8WMtCxGA4mMR+qVeUGFAidX/w7So0tPiUMzghD0ba3R0P0PZCn5xH9HuldBtkx341j3SQuj8VRSfB+2pmPT8CWcqHs6pXomRX8xe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rtF2A3RF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so36326055e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Aug 2024 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724094367; x=1724699167; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UEtwhiDLRyDYkOKHIKV2oClEzfiqKDNu1A7NXjK9I4=;
        b=rtF2A3RFhQPx99JugRcYB8yHOWnfqIUQpTZ09EMrFCDISz3g3TUUa/JXol8BUxOPH3
         NNA9G2A7urL9AXbQCRkFGPqAcDaCsqy27z9LAiFdIsb/r0MPFqmHC57lIbUw55FxSxGP
         yWat9ZWvT7U+RCy8dWbOhLRn661xs+nGzrom6ELhM7aBCv1wuPqxEzuhl2cafjQ4JDAd
         ef/RNpMKrtRNjq0lh9a8npJXoI39kOwnuVTnZrVAMIMAwFkzicry8qNPa6E3BwPJzOxw
         K8WQl8UwkYserkIaKpxB5Jk0X2MVS1wuuEnxj1FHG0L5aJAePyHi3V6ab9Xrv379ei+Q
         efwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724094367; x=1724699167;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UEtwhiDLRyDYkOKHIKV2oClEzfiqKDNu1A7NXjK9I4=;
        b=rfBQDKmE4e9AtQEGX0TOqIMdXBIqTjqLGVcnOZ5xei8Ve3fI0GawdhEG5Ojs+wbbF+
         GUmxRiWKVWoC8L3L252i36elQ13T33cS1sC7JvDzwUZy8Z7zwtcFor/2W5kBMUsk7xxx
         hyvrId+MqHmqM6OQKnTmvOpudHgskFA7w03OP14qeZcsI0QVKzYW1O7RBUW/ipZa493F
         n9gGLkNBNZgI6PewhswVoBVTgwwWu6KIlS1FSO8tXBtrfzzHoXaGc6VFhZ0UcoTpGr9f
         G7CnBSXtSKPH77bv7XTrqDCbl7x8T7JwXIu8d9UBpA2lOgE5idvESoG048PeYwqTbaMg
         bBDg==
X-Forwarded-Encrypted: i=1; AJvYcCVa3g7NFwNS168Ievumd+ibp9w8DxP8tIitlTDiY4UzffVVJioJLwCcuScBZMEbsynkwcS35qWQxNVbK+gXhhgUEDB9z8gHvBVN8BDQBCLr
X-Gm-Message-State: AOJu0YyLcdmCgs1QYDFXeVGs3baPDbbbrOKoA0ywgV1nbo1HJckVZEeT
	4zZVcXSk0QOajyanNTji3HxTUzxF9IMugreMiBzeTZTUZyBD1Ie5b36eqNdV44a6ZiQjXuZGOyD
	WLis=
X-Google-Smtp-Source: AGHT+IG1Etc8UOD2bthAtuxpIsQuT4h8o2ir8tnTvxL5txe5jamTB0vJeRcjsHL3kkTXkK5xwtbjFA==
X-Received: by 2002:a5d:51c9:0:b0:360:9cf4:58ce with SMTP id ffacd0b85a97d-371946a44c7mr5808551f8f.46.1724094367018;
        Mon, 19 Aug 2024 12:06:07 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe2639sm6131910a12.12.2024.08.19.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:06:06 -0700 (PDT)
Date: Mon, 19 Aug 2024 22:06:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hou Tao <houtao1@huawei.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/bpf: Factor out get_xlated_program() helper
Message-ID: <1eb3732f-605a-479d-ba64-cd14250cbf91@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Hou Tao,

This is a semi-automatic email about new static checker warnings.

Commit b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program()
helper") from Jan 5, 2024, leads to the following Smatch complaint:

    ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_program()
    warn: variable dereferenced before check 'buf' (see line 454)

./tools/testing/selftests/bpf/testing_helpers.c
   453		*cnt = xlated_prog_len / buf_element_size;
   454		*buf = calloc(*cnt, buf_element_size);
   455		if (!buf) {
                     ^^^
This should be *buf.

   456			perror("can't allocate xlated program buffer");
   457			return -ENOMEM;

regards,
dan carpenter

