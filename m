Return-Path: <linux-kselftest+bounces-32438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DAAA9D36
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 22:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A063B9548
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325711DEFC5;
	Mon,  5 May 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LLMVf8lE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0CE1DF97D
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477105; cv=none; b=fo+T8rCfrK7eiWtWbwoJl3b8WSjhLZEa74SfGouasH/xdoKJHpv2Xwrl1BWCCGrjipiX/AyjTHaG1G2aQ+mbJy1v8TnxiFlEnj4Smz1Jkg/iVRCso2D5VF3OYt15Ynq+3zqOyaw3bnzmNUghH4yhJWXUK0Bmwrkg8826qBUczRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477105; c=relaxed/simple;
	bh=Jvo/YhqIjXOfgWKWVr/xOXRXys269a9eHbiCnC4yzcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njawG/8oxNUhUg5Mbfv6zV9u5i7uD/OLixlT4aNO3b8ckoYvvP7MMrGU6w/HEkhqTiT8IR8GjkImjL+oKSsks6evkziuBUan5a7RQzF0iXNymsnK+NWahYJsLPHFLGkyQHsO7Tx+XK9TYjHAtjKTaUdgbiX2F68PgWwSszQEGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LLMVf8lE; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6ecf0e07954so80224086d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746477102; x=1747081902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jvo/YhqIjXOfgWKWVr/xOXRXys269a9eHbiCnC4yzcA=;
        b=LLMVf8lEuwOKx06CaTrkHHbHABoHe5K12CpvA0w4O1MZ5LRXsozswI1KKLdYxbCecC
         kQdcQ4iTbjcuBYZJZGMytnXH/DoHMLnb7a9c1bTSo96hMTbinO/8Jv1OVZERXWv+3jqP
         dAj31G3aP7HR34JcgKvQbQFjdQoPtE0YbiRPTAOnRxinHdrll+TccIZ2ws3UqCw6AAB/
         GB4zGOYwr2fdoLVZpVmkodMVq2yJZTCLNLj+us3henDckincdmqtoNW4YDIvn6O/yHZb
         +boiBz2gsdiZD093pfEsdI90k2TsOv42Mw/oIyR8TrO6G4ii3evWN7doi7zzX8Qa01i2
         4m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746477102; x=1747081902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvo/YhqIjXOfgWKWVr/xOXRXys269a9eHbiCnC4yzcA=;
        b=nv2iAsRewKqjUj3yuEKZ1MyITg45ZqqpGVh7/ne50GZFcjavZrCtYhAR/pctZGhnGl
         fENAL5pwPJOnJl806j7zD2WAaHr2bJIGgRIYcVEx2DJc3Ta5FMvju3pA1G7/LCA/3TPm
         N8D4uM8lLmygu6CRzUo8gbcSMwVbF8o/k/bYYNLGlCFfiWa/Eni/5ul3L7EZXsJL5nYX
         vbzOcgfU4Jp55SzwpLc4pT9WfOGL3HGb5OKR25ampzOlT61YQCCT7vyQQ2aKXPuPkIGS
         SNXDdvEL9b74rkSsN0m+ASgLgp40Jgcy7DJVrH4aB/Rxo5jQ3u3PmDm0V+La3SbKvACU
         p8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXk9U4inW3mpPoNhqaRwbhtJWNwtkE2k5swTMJUcRSZEuzOybtK7zof6H86dnjRSC2R5T1uUAKwsXCucDHgeL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDwHJffgDeER/RkpZmL5xXZRZKJkAVr3+hM3E5IYNazXzO4cy
	VT+cNmY0TvZ4LrcHs0LGd+Qv+yPhU0+Dl9XtW1sOHalv32TT/GtW3GMPBC7SohsEcFFP+ZeXfYH
	aO//FnMmj6XgzhDyCzRIrxL+pWcCLqxAK
X-Gm-Gg: ASbGnctuBMYAo3rXwyEGDKp6/QSQo/8sZdMWMmjJFt7qfVTJfRKwhQyBVV8q5OQBUFw
	O7esSIrartglO9MbZbvLn6zspNTM2fcEFqxTBU6aGDWOKe4RVrqPr624cv9PXhJlYxb9YmQGP3/
	4KPbEDyS91eEISmvNT/b7aMCu5AfWFRxQmPvdgpTCpzcpmtzGfaRdWo/xKA3OEeMkvachs9uQaY
	tl9bN+a+ZzUUSpBDhm2+lBxIBIF3K3dWEic0uXetrM4k9USDoiaVSRyAmUOLUJIr3F8dLL0h27Z
	w4DmywGrWtptYWT0nkrvNiUjDccBhWN58y6wFttDjupD1w==
X-Google-Smtp-Source: AGHT+IFjyj7LaxQN5e+7YK7FuGnLBthZu97bImvgrg9DXkMwiEuu/3ei/Y3A5hwO46/WZOpmK8fMARAjTlxM
X-Received: by 2002:a05:6214:124a:b0:6e8:f99c:7939 with SMTP id 6a1803df08f44-6f528d126c1mr126873906d6.44.1746477102056;
        Mon, 05 May 2025 13:31:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f50f3abcbesm23261896d6.3.2025.05.05.13.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 13:31:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0C6B23401B7;
	Mon,  5 May 2025 14:31:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id F1B49E401BF; Mon,  5 May 2025 14:31:40 -0600 (MDT)
Date: Mon, 5 May 2025 14:31:40 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
Message-ID: <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>

Hi Jens,

Can you take a look at Ming's comment on the first patch and merge the
set if things look good? I can rebase/repost it as needed.

Thanks,
Uday


