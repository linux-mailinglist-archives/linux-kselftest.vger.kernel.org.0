Return-Path: <linux-kselftest+bounces-15068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E8794CF5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD7F1F2259A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017381922FC;
	Fri,  9 Aug 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2wdVlQe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF921192B9E
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723203170; cv=none; b=ZwoCw1LrjK5AnkYMzS4UMNaXW8YgGhqw+M7+VHnCj+x23cJyZl5wuvay5AouDB6+Vsk0PYWt2h8CFCYLJjK1GuutApPzGyAs3hzwbAHCEwHoVt6qVAsh1G+0Lu2usvRrFx13Ie37iwHL6YwTrFihjDL1wC/fNaGNinmPK9hlsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723203170; c=relaxed/simple;
	bh=MjlelYdFd9t/VBIUHkHkn2JnXc/OAkf6OypU7xCsTPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dfhKGF9VUYKs+bej7GvIFhR9glsGuqTsmRXO+dHqmlP6q7iFfkDK9eNSCrzbozWr96fOOJNlZ2pYDkOUBdV9Kl3fCW8ONMMaZnNp6tQ5+BKqE/DDekwJCKGutc7LpaIXVatcrXzvVYxOUR0sYroAC8mnGbG9gikluXHuI5uDHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B2wdVlQe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a843bef98so218385166b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723203167; x=1723807967; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/KwNsAOD4SkGNj4HV1LXs5OGBQrJKXqcXnKIfHM09A=;
        b=B2wdVlQeqIMLYzSlQSViREBlqMF4KM/SzCyhAbOEZY9vOddPKGdPGbkFtQik6xmbxL
         sCeG6csLx+NLBA/pibTZ0f8oge4mECaU2GfUQkcDbEN8tp/d/KU8ZiBSrysRtOqixB07
         w7HlC2/ZoQUQ4pllHKUoiifkHcjvD5bBXP1pzI2Kbls1JRYXvlKfZaT6HGuYzGxn0A7x
         xdUp16KMKhXEQOCrnqfNgjDFbCTHOwWP6PUAjGcbM+jztzc/fsXQU+hkU0Kh+uGxXH6z
         WXZx4xJinsdbCIkmQuU9beFHlP+XK4cRjDue0RylQRfEtMijb29qJf7GKa8Xx5eMIVaO
         Q9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723203167; x=1723807967;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/KwNsAOD4SkGNj4HV1LXs5OGBQrJKXqcXnKIfHM09A=;
        b=RWZABiS1dHPe0xFscNThT0BJJO/x5kLTlKCf96igHKPBl9iIqWgumOCb9PWX9Vhd6j
         xjQWyxiHYEyYg+P/6U4wZtTTwZGsEa9nRhWgEupHzBa3wuuaVCiuHSYCeCqWeQ+DDMtU
         b9yBar1VKGFl+cgFR+UEjVAtkoLqoNgUn5GeFIuae9J1S8iG48/yUwUHU0sjJVwVY+GV
         hJs9sk+EKyiYoDpg31CH9yskLTeKOze7t+p+hyK6UjCJvUkDon8JYLdJe6hRLIRD8Bqp
         kYWbvZ9SSUMHsUPSzincMAy+S2WIjOBfcgATFnw6mXUfmVJVjb9GYntr5DBl1P/cv0ee
         qMIA==
X-Gm-Message-State: AOJu0Yx2ID8XgzRItKuRSRJpl1UDIKVVhWEGh9gA+dnKrkRbqhY3gkIs
	Fucv9lN+aAH/Px4ISVK/AYf5xVA7ZFe+X8gndk9/qC3XU/4GWmu8MpSOI5B7k6t4kDIt4a8p0tW
	+
X-Google-Smtp-Source: AGHT+IEXu0YBPD84aRte4FZYgGVBWlfx//IvVHmEwpLrNPoN/quqwk7Q0ajifeKmYEqZM97+gDTitA==
X-Received: by 2002:a17:907:72c7:b0:a77:cb8b:7a2d with SMTP id a640c23a62f3a-a80aa654b7amr119711166b.49.1723203167048;
        Fri, 09 Aug 2024 04:32:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d43777sm826923166b.136.2024.08.09.04.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:32:46 -0700 (PDT)
Date: Fri, 9 Aug 2024 14:32:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Subject: [bug report] selftests/bpf: add trusted global subprog arg tests
Message-ID: <a5914541-be28-4232-99f4-7bb856e13c0f@stanley.mountain>
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

Commit c381203eadb7 ("selftests/bpf: add trusted global subprog arg
tests") from Jan 29, 2024, leads to the following Smatch complaint:

    ./tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c:88 trusted_task_arg_nonnull_fail2()
    warn: variable dereferenced before check 'nullable' (see line 86)

./tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
    85		 /* should fail, PTR_TO_BTF_ID_OR_NULL */
    86		res = subprog_trusted_task_nonnull(nullable);
                                                   ^^^^^^^^
This is dereferenced

    87	
    88		if (nullable)
                    ^^^^^^^^
NULL check is too late

    89			bpf_task_release(nullable);
    90	

regards,
dan carpenter

