Return-Path: <linux-kselftest+bounces-31546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09BA9AD72
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F6B3B7BAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7B270556;
	Thu, 24 Apr 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eX5YrhpX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3226FD85
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497870; cv=none; b=FGQQInTWz4Og4CG9Xuq+Q8plGVr6xz2q7sswgADNAInMHNBQKlVvR/+LGU21xmOYXSCKifbTGYAJEhloVnsQlAiY+1WF86JHj2+zmhcZJeul2kCyWYFwLIYluBmyAqlkaAmMRZkKYvvSATIs/9LkMRzneJSSYDZ12wMQn8Dn8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497870; c=relaxed/simple;
	bh=WPftREPW4/qo/5xHH+9LLqlgxhde25Fhn0/iIWIwpuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eJKlYGCIxxuwHtwYxHKBjCn9LQLWJKxqkdx/xEUHR873F+OkhVOBqwkR4xyiuqcAxC/F4pdF63GUIgMWAOskUxQvpZBqSB12tIydL/xbdhEo3jvLACLo5Ga2pr2LonDgHqD22pdYuCxzko5L9dYeT4NQT1sq1J1tS4A5NIRCQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eX5YrhpX; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c7e5f7f0e3so226014fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745497867; x=1746102667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pps9V8ncwYdRycRJbT3v3474lDbFCNoVouzd6mCKRd4=;
        b=eX5YrhpXLWESEHDAQA6W29/SJ6NRb7hcv3THQcMZZ5CoZ/HFJLJAtkP6gKZyw+nhZn
         O/clCzNY06950aNnz2byPPXcJcjU6/YJRNXPnMservILBght2mAm/BOZPKYaicULcZoq
         yq38fvvPTRo5uV/MiWPxSvNH1U7Yh2DiihkUhdC1fEbL+R9lvMIVRVM1LnxnOmV3MtaR
         Q2Z0kEyMW9csxK/JkM4hanYTPXkv9ZLZgyfkLP4+kYIEMl2pUsNOjlTIum5d0XmyLhiN
         SlkCIjqgTsXGaJ59ggN7wy+TVWlT5bq2F5J+Qyv00PYwe9FEB+3WoQeem9qPGdPeF8j2
         I/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745497867; x=1746102667;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pps9V8ncwYdRycRJbT3v3474lDbFCNoVouzd6mCKRd4=;
        b=Er01Fz8Bal7BcIzXl0OO0TtWHN3TVtwDLfr+Gl59MfTVOEESqQFkqmga5Lhh8y/4a7
         OlkINxxXXkiVR1VUzGA+gRAaULEg33h9l7xQh8EfAyw2mur4ezeFwZOiaVZdLuaFBqJe
         Pi7aHXS4nKbBp7uqYFdRhher37zHRxj+5xhkxvf5PwNhPp4NXmovMh6HN1sOXII8lOWd
         7nxyM+T8D2jbymugn29a9i40wbHcRXdsN4muG5lV2SJ0h2uQ5NfxzAKjfHKsbU5I2IxR
         OmBtV3D08Z2e9BUUcg3aOvjcWEqYoeR54i1cFgCpGyoiKPBoikXMONbG2NeDMYOeFfk3
         /x9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKejwEeGk7gHRXDHq7NVQ1dq2E7xRgHVdxtf9a4oGL96QBejKb5LUlOPJhvzDmkzYufAiA7d5iv4nRZMquq8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFD68wWyGf9RXBSlvOzRgw/gbCq4Cx8rFSERPUSPZnpT+KQEJ
	6KGf3b36a9vih0+9DHO6pXcrLS+l/tMCdp/WW4g8y9DYpc7uyk5fqKyI4UFBZuc=
X-Gm-Gg: ASbGncs1I5fzdnS1EyKRw5Q1TbFTKuCErFJLKRw9ElEjwzf1wxaGfozR6K6tk5Z5t9o
	qjKVP6vYP4ZqSj2/gcXc4t+iYNj7WTlrNd7ukeH7rDrWVIlk+kBq6X59MQIxAxFbWWwD1VRk6uf
	mKG2EXwW1FI5YmnpR4weGDOXVxahDHw4Ou6n1olzo9QUdq4gZJt7emth/MlPhFlGcJeMXqimn8f
	DJ0ehKkoy83p97XSl+846t+QCZkICFonVRcsZ+sxafrKB028huvUm2bg5BeCBxK/ci7AsfN+Yaq
	5qGGvgJ6FRuKpzkTKl0HOmDNUhMchWJg
X-Google-Smtp-Source: AGHT+IHcDAhbNIdVSY+XYgylitasV2oC9fI4HWvx3NtkldPFUlYRuJvXAwP5NGZRmvjfiIpdimj8HA==
X-Received: by 2002:a05:6871:5809:b0:2d9:45b7:8ffc with SMTP id 586e51a60fabf-2d96e21adf2mr1149904fac.3.1745497867264;
        Thu, 24 Apr 2025 05:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f8249f8c91sm259639173.15.2025.04.24.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:31:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
Subject: Re: (subset) [PATCH 0/2] selftests: ublk: misc fixes
Message-Id: <174549786571.628784.9329773694519239539.b4-ty@kernel.dk>
Date: Thu, 24 Apr 2025 06:31:05 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 23 Apr 2025 15:29:01 -0600, Uday Shankar wrote:
> Fix a couple of small issues in the ublk selftests
> 
> 

Applied, thanks!

[2/2] selftests: ublk: common: fix _get_disk_dev_t for pre-9.0 coreutils
      commit: 1d019736b6f812bebf3ef89d6e887d06e2a822fc

Best regards,
-- 
Jens Axboe




