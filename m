Return-Path: <linux-kselftest+bounces-4372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B8D84E9F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180822934D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCED848CD1;
	Thu,  8 Feb 2024 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB0vd2QE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7038385;
	Thu,  8 Feb 2024 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707425494; cv=none; b=Z4wlniR6jmuq3SeTb/BpuujJhckcpKxd0DywoeEOLuRTnbMMNT7cDwERu/fwiDRHHD87RGyCh8fXOTclAcPx31/txmZHZprKmIKsMB/6bX/4ov4NS2eMKjNDQAWiCAIv3t/u7snej6fsYTL+zvW7zG6qOANZvtLoVgOjPJr/Xwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707425494; c=relaxed/simple;
	bh=sm8uQrEOfdfvF2X+EvyKhAGidf7HO+Jtciuv0HVc6qE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pxNVreS8x6my8bTRa5I6Zj+JDxjPljkD19BQlSztRb3mpAMJuv7b/Mvh6Q7O94xXbn4yneiv7ACjvzfh8/SZDGHrO7a0ZuHvxyuTlDs5Mlb4juJQhUWPvYoDWXZuU4l44tkYii6wBcby0O0y2m2GpDbH//pQIoW+/RtDXtp6RiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB0vd2QE; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bfedaaeeacso125102b6e.0;
        Thu, 08 Feb 2024 12:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707425492; x=1708030292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TTQhGymrB+mjkxDaS78rz/awRKS+8KTVwd9AhLRl6M=;
        b=DB0vd2QExf/wPM/ioUaXoxAaiKqAVrMXP627B4PX/drwo8fL1b21zJv8cpSKs+H9Yn
         +QZZDXXZtbfX0nTgqUP3kvJFb1ozS9Z0tFGl1i4aQK8/ua3ZFISH9x6V1Hu6hSd7tSng
         Y56uM2AHW9VR4l2oK25gMX7ILtlHA8Ks+IwrT6cpiAHF70typC7m3iNItNPvLU5h/prt
         P6/pXqRIcXreS+Kl+1ln3CLEhSM/hSiMuHzojdD8Lix8TaYPUyvgv36D3eGTHIiJcJYW
         CzcgPNmTzitlsvB1bLzaINFA7xI2gn7ZB1oCGYGts0DLveFFrIUetKy4aT6jZ4nO0mfc
         83sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707425492; x=1708030292;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6TTQhGymrB+mjkxDaS78rz/awRKS+8KTVwd9AhLRl6M=;
        b=KZjDCPmzILOP41Qtq0EnFM2q3VOdnsbhmYuipBVliuvbzTpaRKPkT6XpFJw/C1ieLv
         Y6OcxRljojj8ExrAwocv1x+S3zGgHjEzMLM2d81ZdwJ+PrZh3Xl88Dyo+3eSg9A/cI11
         SafnW2AiZvnHnsWmysyyiok5ctJh/rk+C5wEzIAPsoR0kglDSQeN1/G4Tvi0T1B4qZ/2
         Ciz43Zff1uz3qbmIWneYguPdUb+MbZNVfr0HpLEirsmYC0SiU8k9Oy8IGq14YABaf/oB
         kx5zuKHvlM5BFLp0qJJmCK9nwrvn/xSFUTOgBMxNzeuFHV+gBa92ACTHLqPXwUNS3ww/
         zz9g==
X-Gm-Message-State: AOJu0YwyobR2Qqdur3XCKKUd1CkKouU2HIMqWt2rTCJJKMzVMvMOlQHT
	nlkWrMiT1N45enyXTSdwB8AQu0kVUZyi4UaDqeyLbIT6n0wbd9Wt
X-Google-Smtp-Source: AGHT+IHFk50jH2OsJ6VFeNIybyD60lzXrgLoyMmMtplz9rWvm4r8H2DxOWLnxBUsPLZWQubjAo2aSQ==
X-Received: by 2002:a05:6808:11c2:b0:3be:bd8:31cd with SMTP id p2-20020a05680811c200b003be0bd831cdmr551962oiv.53.1707425492345;
        Thu, 08 Feb 2024 12:51:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUacJ7ZjcbuVyx4Wh85yUXVrlDqPHxvF/+Fw0Sar9tk3KHw6NvEWrnEfh4CZ2b2m/7AOOQu4C+gRAEQ7S6Rgt96xqyC6I/bxpC2AeV1Ay0ffIm+cMHQfwluxosjQT2o5htJfRXgDPM7hfiSkif9/xq23ayZVL4NVvpN+A8/ohTK89xIilojc1TjuxeN/oN48fH4vcrgUJXthzaYjWleMos=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id o11-20020a05620a2a0b00b0078563251932sm147491qkp.99.2024.02.08.12.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:51:32 -0800 (PST)
Date: Thu, 08 Feb 2024 15:51:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <65c53ed3bbeee_1ca1e229434@willemb.c.googlers.com.notmuch>
In-Reply-To: <bca0a7a2bac7fb1db6288a54936cdacdb0eb345b.1707411748.git.pabeni@redhat.com>
References: <bca0a7a2bac7fb1db6288a54936cdacdb0eb345b.1707411748.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next] selftests: net: ignore timing errors in
 txtimestamp if KSFT_MACHINE_SLOW
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> This test is time sensitive. It may fail on virtual machines and for
> debug builds.
> 
> Similar to commit c41dfb0dfbec ("selftests/net: ignore timing errors in
> so_txtime if KSFT_MACHINE_SLOW"), optionally suppress failure for timing
> errors (only).
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Is this still failing after commit 5264ab612e28
("selftests/net: calibrate txtimestamp")?

