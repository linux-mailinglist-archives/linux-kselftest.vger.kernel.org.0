Return-Path: <linux-kselftest+bounces-42009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 483F8B8D53B
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 07:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A6D189EF7E
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 05:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9EE285069;
	Sun, 21 Sep 2025 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Rf4ZLtRn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BF1A8412
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Sep 2025 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758431935; cv=none; b=CVAgBxKl+ZNFPoxu3GpJLVvn2elmdLxjzp8ScxWwMvQuf3j+2LRhroBera5pMXgzv700WWpGvBmBP7cSGD+Ly60vfisQvQldX3iKN9NzLEiZNR465gfns811OuHTyENp9DjFG2PlV51GjABMCnPEDcOeW5Nm3KTag1SI7NAar5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758431935; c=relaxed/simple;
	bh=TjboM2/L0f9nAWei19mZ8FDgalcu/2Q2kDV4Dvf75pU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OImk1CfTEMIGfn5EYB4ZaPsuNV5BHeROksDXJq4LydUbG7GsK/IQNi1BcvEAtePR6rmwa7GT+FlFQJMJBFjPC4Y/Uz3x2c1NsjTYp5EC1TjktiM5nLMNONZKsMCcbfabKeI14ac7pA4DD8tMhH2fZEzKC7l8qf8EHCc0GtA5yBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Rf4ZLtRn; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-42480cb42e9so12399985ab.0
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Sep 2025 22:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758431931; x=1759036731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHhQbTj4kYsvAqUw74p0VJZScNEJAQRLYPDi0Xv2iJk=;
        b=Rf4ZLtRnM/swyZ+onh9AIO39xwimd1PqNKZpqiFBSx0/evRNqadCxPKbxA7FqoT7/e
         KXMA3YJu1O+rlrAZYK6bC3LH9qHqlQgexvPR8SuN8ReGxLtm4My0LX3fC8Q6n3Z7AHaK
         VOA4j6urQvn8hm86BtuezdHi51GF3Lnz4Fh4Tx1ctqB8ORj0LNn35mjTn6tcb/e/Ti8U
         K6tbpBDSpVrjr8u8ghFQRmOqdxcLN72X2B6Ez+CPgoGi2nEpMPTTTjGqPsqOH2jDh2io
         ik8Rdx9jmDYjT+LhA+Zhp45BLjJE3NJD+qJ+UdC86DMz/V5ef8rqFV6ZMVN52/t2fK5J
         YK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758431931; x=1759036731;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHhQbTj4kYsvAqUw74p0VJZScNEJAQRLYPDi0Xv2iJk=;
        b=LMolNb0WeXeR7dv2sa66MSUomOb9Wr1B7HEBIUi/4g/kiBfitGpuCIpSL9LaldVun2
         YV3FcZdCo+JTebCBWnS65mnuPPMeh0+bNzr0k6g/s951/QRkCbIZ97j+E3w7bwD7bYWa
         g9sipGOjpdL1yFdWw9qEzvxRjggQAL/rS34NLOw6zVMGtqWqCnyYsFe9HAJqpVdGU5ea
         LcE1szMhqhpNhfie+Re4B2mTOkGsp+Kcc4SH/lc3E4yke2flm29StpugF5zCyuBhNDE5
         dmCiiPQEtzCy/MVWSd+uGmx1JtBZpmyipE3q4eaYo8QaZvAZsqbHhtIx18jJRHuFhyiL
         cvYA==
X-Forwarded-Encrypted: i=1; AJvYcCVeHqvxnsrZi63laV1F5f0qL4ef2iTpDbkgpcfGoszz5NbMXjiU76EYxkNDbIYH1XYxVSlME55jgXDzrF/oDdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwPzzvd2zVP5zzRMAGW7YjsvIcH1eMNd3ata6UX9TMWcyGE0N
	McJDfHhq1W3E1FjtsMyc5zkkfzzwey9h7cHUEW4FCp4vy5FRKliuQwMf1yUix+ZLiBg=
X-Gm-Gg: ASbGncsdOk1qDNt9gPSxu3KtIpsqmy0h5y2ZEGAmBhouH3RORxhmESEj2rcUzYj/gRI
	AfW5CuBtOXsedAj3eZO2XEzR6VWDWWRdpFR37A2GQYJbg8mG43gfA68A63JoVfhbgWJ0a86gQmA
	/Oomg8OnxuuDm4AhRBNVJmHvvlGJyo8TLW9FJRf8kyY6c0Ght+IMN1YMZmsgz8MVi97JPla46BQ
	LBj+FS5ZrjdINKhTzmRy2EEC+preCrzkKeHe5E1DwK/vaGHksc1NkVcLD2UFI/LbOErNgg84QB5
	34RRLw7Ytnemi8A64mIPZeaJ8d4Y81+r+UpmZg0MOCvW6193MaaTZ+Oq5ArD
X-Google-Smtp-Source: AGHT+IGjpV4kJ4Qy0bZ3vJ4qp7i08XpmUB+fTdg2aDRru5IriHCuc6P8XxrDuu6gS89i52MJD4LExQ==
X-Received: by 2002:a05:6e02:148c:b0:424:80c5:87a with SMTP id e9e14a558f8ab-42481984015mr120728015ab.19.1758431931221;
        Sat, 20 Sep 2025 22:18:51 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.67])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d50aa5db9sm4228746173.43.2025.09.20.22.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 22:18:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Mohit Gupta <mgupta@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250916-ublk_fio-v2-1-04852e6bf42a@purestorage.com>
References: <20250916-ublk_fio-v2-1-04852e6bf42a@purestorage.com>
Subject: Re: [PATCH v2] selftests: ublk: fix behavior when fio is not
 installed
Message-Id: <175843192257.42245.2136343963364128168.b4-ty@kernel.dk>
Date: Sat, 20 Sep 2025 23:18:42 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 16 Sep 2025 18:42:52 -0600, Uday Shankar wrote:
> Some ublk selftests have strange behavior when fio is not installed.
> While most tests behave correctly (run if they don't need fio, or skip
> if they need fio), the following tests have different behavior:
> 
> - test_null_01, test_null_02, test_generic_01, test_generic_02, and
>   test_generic_12 try to run fio without checking if it exists first,
>   and fail on any failure of the fio command (including "fio command
>   not found"). So these tests fail when they should skip.
> - test_stress_05 runs fio without checking if it exists first, but
>   doesn't fail on fio command failure. This test passes, but that pass
>   is misleading as the test doesn't do anything useful without fio
>   installed. So this test passes when it should skip.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: fix behavior when fio is not installed
      commit: a3835a44107fcbf05f183b5e8b60a8e4605b15ea

Best regards,
-- 
Jens Axboe




