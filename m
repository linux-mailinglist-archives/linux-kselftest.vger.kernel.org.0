Return-Path: <linux-kselftest+bounces-26755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5B6A37AAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 05:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4465E1887A8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 04:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3233F156F54;
	Mon, 17 Feb 2025 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTLKhIUj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8433E7;
	Mon, 17 Feb 2025 04:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739768358; cv=none; b=gsjI7M1PnQ8qlTaG2qVCBnK9BWCEy3FICxVqJuFyIjGvlQ5DrUDp9HiO65CBgMIXOz9qxjC5JdLAHVW1WGwKYg5uYtEVRERedk6mAXI6yiWNZHjAz8nYIJBZzmz8R4N6IP0Rhf+NizRLj7PKiJJOGLGNJUfbZOlpaRlgrT0W7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739768358; c=relaxed/simple;
	bh=OZndBUo8EfPLIqHCZQngxRdKT/LTpuo8iciiaO6sdMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nspRX/UupWvTBvjHOLrVQ3kR95Tx1PE8J91jLWDWdKF9IlbKH1RQshgtI782Xa6s+ZwYgoPQKBqCoYKCeqQ+q+dJyhvXb4fsKMMsJl6B2Q91XJeXjSM08+MmZ0eFGCVSV3D/0CityK72dZ5h3EHf8of+NEBVjmy0TYZQ56GUps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTLKhIUj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220d27fcdaaso9863765ad.0;
        Sun, 16 Feb 2025 20:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739768356; x=1740373156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxLbwgWIIsiwz12Q3wR5ZThu5p3+PxmE8Lk+Vj4MQaw=;
        b=PTLKhIUjHTmvt7SbtgwEDuqzaa6ZUSbh36y/TApCZXTJW9p29wdUL+Vg+58E6sriC0
         Jjy8FCQiaIzhKaM8l5S335snLFoRidy/XeKHW+TxtIfJgxyr1uBIhtJJ/f25G8gjSPJD
         YqW5IhU4MM6YIKNn/kERl+9cNTzp1/ve2z9iCqv1YYbAxyHd91uFN0QygXiA7aBvnvqY
         Efchiut1PG7pkxC5KkBOjYD2Ga1xgm46tKhZOGfvqsPVLJxUe7Rb19P5PlBJZexAOrlX
         UeUrFJcwLZkZzUpkY6Zc4xZwZfAbVFqfxNqbl+O0joOBvkOqc0sip59lARGGw64JSurn
         LGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739768356; x=1740373156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxLbwgWIIsiwz12Q3wR5ZThu5p3+PxmE8Lk+Vj4MQaw=;
        b=orpVRbT2dV2JTE3mgz+hv4cy2Rtoh/cukgVpsnqoEOGwuUkhkUNHfDtd72kGxhFZ4T
         zRWiNodYFiz9fErRh4B34D6UEkKRCvNH1D8zKuIAC0B1VsfGc5bW94hLts2IZUcNkAw5
         4rXNFxcT5dunSIFCAjMTiSma5ZJsWqAPDNZC/N8e/VdlTekZxQrUhFfpnJ1JLPowicuk
         TcJ5M7hGzSfvHJiqT2WQYTmO/6x2a3Lz1+pgEPFFqcMPhpd+EUJtFbVyloNKh82O9It1
         LpzJSbaMMCcv8iTHbDf2PuzsWy2EzAcVOVOe2VJrGb93SfQDRCCcCU6N1/9aLn94jLDO
         TlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3tjbWBz23HTOrgsp3ofe/t0zwKSCdeSt6JD63ukRMScFQ1TVAw+zVwIRM0XZTwmY0OCweHJE4dPj@vger.kernel.org, AJvYcCVYSZmkPeN61NeCscBdaBujOcoRIbmFQkNYIfxseiek+JjIrhTaHSKqqj7/pQePe2XCe/RPTvOOeNPtd/lk@vger.kernel.org, AJvYcCVeI1ablqbtwd9YevIdPxb2sUVQ3UkTHNY8kWE5c6enkO7r7UJV7G6O65ZnMbwNWCvvObHTTzmns7dhnRp+Cob8@vger.kernel.org, AJvYcCX3r6dyvW2EfqCLWEYe809jeVDH6/e7qHC111TnQVAeoakBcYshtUFHtxdjGf7JLryvqsuzeBuoY3MbEdKG@vger.kernel.org
X-Gm-Message-State: AOJu0YzuIau17BXtZuk1SRWQu5hAw0iKfI3oJA6n2C80uV1VwOfwJ9+t
	s0k/Cagk8289CR0/7EYm5Ra8cI1uAEinYtO0U29jsWd51QOl2nny7e8VWc4kHaM=
X-Gm-Gg: ASbGncuJqCWrq2gPepU50CPm7bFeoB4FFME05orI7uQ9JqNMPlrSFx/DL2e4xnlP/CX
	iC/jxnQUUUawGchoD9QXqktc5bVEdgmqYVmZvs2/vKGgpXyxl62Waoxh9zOR2PSrJ+RAENnwNim
	q0o/28NLT3VVZC60r1N/6HXDCdTk0ut7Kc5koB92Kpu5Yq5118FSFeJlGibK5wEzegxFrzGpTIE
	kGdWE0jTP49NQsC0IZZ8JJVcByFSQyK7HInxix/GtO7owOsbI7VQkg+vXumpZx6zeruNSozktdt
	7jyFyKs1AP6nm3UC7USp
X-Google-Smtp-Source: AGHT+IFeSLr3LXtCRfU36DYllnMnA7MAvx72SK+lw4rQyyiFZ8wrzuJf5X+7s7FnNdFu+V4DjMUqVg==
X-Received: by 2002:a05:6a21:e8d:b0:1ee:66f7:2b8c with SMTP id adf61e73a8af0-1ee8cba0f9bmr5271769637.7.1739768355932;
        Sun, 16 Feb 2025 20:59:15 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adf06b0ada5sm1476194a12.19.2025.02.16.20.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 20:59:15 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: manivannan.sadhasivam@linaro.org
Cc: arnd@arndb.de,
	bhelgaas@google.com,
	cassel@kernel.org,
	gregkh@linuxfoundation.org,
	kishon@kernel.org,
	kw@linux.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	shuah@kernel.org
Subject: Re:[PATCH v6 3/4] selftests: Move PCI Endpoint tests from tools/pci to Kselftests
Date: Mon, 17 Feb 2025 12:59:10 +0800
Message-ID: <20250217045910.102934-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116171650.33585-4-manivannan.sadhasivam@linaro.org>
References: <20250116171650.33585-4-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I encountered error when running make clean under tools. Since tools/pci
is moved to selftests, pci_clean in Makefile shoud be also removed.

Best regards,
Jianfeng 

