Return-Path: <linux-kselftest+bounces-15082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F8994D513
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB2A285764
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B599D22087;
	Fri,  9 Aug 2024 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3ysCgGD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D82F855;
	Fri,  9 Aug 2024 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222416; cv=none; b=Wqgy2RmDIsYAykzGZM9ymHhacSbHUqB0XE/mp9pkYuUVAJoET0Io6GsrIgV/PNSY3i0VTMLWPeZQIRKvog87DyBRNKdQDYXwOTRZnMLU7whCMVt20WmST3tyvZapf4JBoFU0gzin7d/fuZbhQyo79+G7fXz+oNgvAvvDCOX79AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222416; c=relaxed/simple;
	bh=W/q0Lo5fEvvh+mgQSJQvkXtSXnB9SHntg1Uak/T2Tog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSvajX6blXo5UQNSyVdoh/0cOEsyqgmGPfAVhJrWeGR0KI1q82YET3TcyYDAF/lKUWcZTELI4jmOSH9i7A8dhWzaUCGfLooi6vCSYLV8QAg1r5SDnxieeGzktc5wDzM6VDvd43/Fb5tqxNwIMj1mLS1POH8R/8qTFCsmT/bZnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3ysCgGD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so1718649a12.3;
        Fri, 09 Aug 2024 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723222414; x=1723827214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/q0Lo5fEvvh+mgQSJQvkXtSXnB9SHntg1Uak/T2Tog=;
        b=e3ysCgGD4yS5BCxi534a1LSDGavOcXz70D4XTPak6TfL1R5y/t1CiHyolkDeyckjnO
         LdDxOPrqjsAKxhaUOcrFcFKe7UNIUQS6Vnod3zRtnvYQSJA9xrK6usBnLmFL+DFzIZsz
         uUlbOvjpVb6sbgWET05RZvLA3Q8edAW6dgAOKUSFFFu9ugd2gZqBqAVw5Vo31fUs0OkF
         4jk9O3uSPIvhwyjLXU8iBE3jyt/hfJTOPAueqPqkPRmAAcI4PdO85qGBu4AgOJUv2bDK
         H3AaGaTAwnsz4B3CY/MTsT2xzdRkjHnU7xUwqZ+7ZOxHS648NfW1MEofAvWI3j0YH8GR
         Wwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222414; x=1723827214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/q0Lo5fEvvh+mgQSJQvkXtSXnB9SHntg1Uak/T2Tog=;
        b=wLSE+eNg49t7djwgLMsC1sjwlNqKUfgZhzCaNyhjrQ1XtrEMUGc6iRMyqAMJmIXcdQ
         pIvXDEC5Wd/mjY2WxMyKUaCP3C3F9YsbXxFErZjNjwn0x/ma4O6TuybDfnd4O/uwu+kF
         yzJoktZEIRILNRh1olglyx9OZJJFu+//0GIxokpPneHnFZ93Y+XbJ1BEO6LMTZb7koN8
         oJR3/ICb6qic6FCUW+xtJwlU9VkJnT+jrRo3ZfDXHGI7CkG2x352/S/iNmB55AkyE3GW
         tYy8krAD2W1QdQH8Tm4zoK591px9BsM3216s1tynDKUYdolY+T7JrByPk+PrWV3nrDc7
         S6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmg6OUZs438FEh8UFn9UykR1NpBmnQY10ItEzqq8cj+DsBq/jWmbeEFfcaTfYu2UaPz5ExCeNIWpeFswtxRGBv4+jSQZY+bowWwEDvB08xZ5H1zdJBgOprWkPwdkK4VYisQ25O7hIbWVZvvI6yF+QpSKuefqruywOj0tpezZ3Hm3Twv162
X-Gm-Message-State: AOJu0YxIn5Q3l5i+3GkxI7J5Sb05NDakdoUagNkWrodI3PDtXOQfICrF
	f9L7hF5tfBj4m4X+x/FBezhbCNdSk0+3I3wxF9t1Y47eeOI0Uszp
X-Google-Smtp-Source: AGHT+IGG5UW+BLY2K7kyUpG/5+/cGAzOozdPxAzCcDq6IniYY3vrKnO0nehWL7flnvtJvhpEN+dd4g==
X-Received: by 2002:a17:90b:951:b0:2c7:aba6:d32f with SMTP id 98e67ed59e1d1-2d1e7ff2687mr2603822a91.22.1723222414471;
        Fri, 09 Aug 2024 09:53:34 -0700 (PDT)
Received: from dev0.. ([49.43.168.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b36067sm5536126a91.41.2024.08.09.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:53:33 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v5 1/2] selftests: net: Create veth pair for testing in networkless kernel
Date: Fri,  9 Aug 2024 16:53:26 +0000
Message-Id: <20240809165326.382044-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808092309.2a811cf4@kernel.org>
References: <20240808092309.2a811cf4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Aug 2024 09:23:09 -0700, Jakub Kicinski wrote:
> A number of checks now return SKIP because veth doesn't support all
> ethtool APIs.
>
> In netdev selftests we try to make sure SKIP is only used when test
> cannot be performed because of limitations of the environment.
> For example some tool is not installed, kernel doesn't have a config.
> Something that the person running the test is able to fix by fixing
> how the test is run.
>
> Running this test on veth will always SKIP, nothing CI system can do.
> Please make the test use the keyword XFAIL instead of SKIP when
> functionality is not supported by the underlying driver.

Ack, understood. I will do that, one clarification though.
Currently, the tests are using either PASS or FAIL and no SKIP. Based on
the above suggestion, it seems that I have replace FAIL with XFAIL for all
the tests that fail due to functionality not being supported by the
underlying driver.

Please confirm if my understanding is correct and I will send a v6 of the
series in accordance with netdev patch submission guidelines.
---

