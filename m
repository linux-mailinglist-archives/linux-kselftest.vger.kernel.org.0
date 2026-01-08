Return-Path: <linux-kselftest+bounces-48460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C9D009AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 03:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A90E3041A5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 02:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698A23182D;
	Thu,  8 Jan 2026 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqw4Zkjo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8E21CC79
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838095; cv=none; b=GlAd4mglnRAP5vHg/DEGVNw+sqg7/DcfxH59ASw4YCYBnuAKmAYGjRf41dqpXga2ex+E4qK1HjFFFvA9IJ3xEHs6Qj9aNHb0jdkmiDl8ajfvGGFt9W/B1dUwKKSM8ckUZM24EWKaLanpmqjZrwoN6WRQ2sQNBtlyCBOOC7jua5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838095; c=relaxed/simple;
	bh=Ppb6H5HUGceEyB/3Jt2uCslY/0fkuEfSp5CPRMc3lxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E67bML1SVEcYAnlE1xEuyaLtF8LjlImqjy3k4q9byzg7ewuFT+xR4WrutRytc1YkJUPiqrj1Vsga1MG4LaP8uuI4KPz9LGvXGAhSBdWdIQ33e+74UnHhISo2zjajqHlY3fPxS5Z8bKhSQpef4pvcag9vtQs+xTIajhjPQ2sW6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqw4Zkjo; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b04fcfc0daso2369678eec.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 18:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767838092; x=1768442892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ppb6H5HUGceEyB/3Jt2uCslY/0fkuEfSp5CPRMc3lxo=;
        b=Uqw4ZkjogZjpQCAEFgDCYuXWrRlBRMw9eU0hBwnl13ySEWLTE36t2ebbYX0GmIq38y
         cC6AbM3zD/uToAxWOq1/0GjHPOL6nJvkIwlO1CTyXYjgL/YbapAJoFYA+v2Eao+yfqCj
         Cw1kAwnSRo1+RN7Ce+PPSTJOHaF0hUwI8mDk1smQgybOknQC04GwpM0RgqKWPTFvJnYy
         /7gJXeyyrP9164XZ69mJ5FyNr8ccvVeiN4JoRttScdp67er+88T0ImqOf+bZMwYZXTNn
         VAFxtvBixFE0zP/O9cLwzcaGiL90SW1O5gWY7GY8py86Ku6XtQQO0bB+ObVTDLGgoVfc
         qgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767838092; x=1768442892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ppb6H5HUGceEyB/3Jt2uCslY/0fkuEfSp5CPRMc3lxo=;
        b=j6pQCqP/ae6DVb1Wi8SafcIK3h1ewBxAdY6V8dDlhnFbxkE1YaUSKzxHBQ51OhrmvV
         W1jvWZUOHlBcu+xXcOFagisSkUG8/hqGkZEtw4Z1iDZ7VsWc7Lwpl5tg95Ezt8RTdltx
         neLR1kBA9WG0MZyX2B2BYqGayOs1US7hrcPlR9opVGMz7Xxxj/mCQCUdZuQVwah9np8Q
         VBPsFVmznin84XnV83BTfT/g63P6vjx+N34iu10Wm7C1BhwMuGa2m3bxSEEThKZhd99D
         uXLAk+lq6mkFGRRVqMqQwng7fLbT3Rl2jH6T4OSH536Ztm3/cCtrU5LEc2LSHOki5Ln1
         8kKw==
X-Forwarded-Encrypted: i=1; AJvYcCXnvphFkdzIeIbuYxc8hokGj285sfinOZQGmFUzOZw3Tw9hytxz/WuS4A76fjoHzeDWpn3RchkuUh/Dt2PjHAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWxJPGnZ1rUfKwy/RTF3cdwzARyMlD4rcuk0Newgn1MZrdgTZ
	U77vjsrhfNzXc43tWj3kU2FexzgWqFLlyrlEL2dwXCgOdpP4YrlmCprY
X-Gm-Gg: AY/fxX4wJzB/9aegGplhLfxDxB27aS4V0ELQe+yfyjw3GqWuZJUkfJonxauQW0tuQXx
	chH2xy25jaEmt1gvv4EfYtlRdwqNGvKm3Q3Z/g3S2KsZgXWqic1cfq+rtNHpTSOsNMi1R6ylj3y
	k50Xqgssh0IOZQqR+ZuR3+zlL8XAjj+Oz1foA3XwtYNSqEpS/Z3MxpLuc2SBkLd1y0wBLLCQiKJ
	9woRCgtf9ON8PUgL23NYHKHgFfmwen6c6MyQPmlAYhrRebhwiZ4nmPNk4HCRdLnuIihncjItQPl
	oLBkR8og4iVhIygBGCkuCVWdwK0QLY3GAVXIDlFdH5kglaIcw7f9Pq6AR4fPxM2KlOw8jDKdrQx
	gWGeH1N0Gq8uRbFqvvvS9FQiL9RqqfbPUBdLRu+5YYVEOdPSzS35xkmCvd0UL7C1vcLF7O6IBcp
	8H
X-Google-Smtp-Source: AGHT+IHlwOdGSSFLAoaIUg9si0C3CEIyX1UC57Fv6JP70RLF+X1LeT6zcnZQR2MFyMwhnAPu8ZWCmA==
X-Received: by 2002:a05:693c:3741:b0:2b0:4f34:eed3 with SMTP id 5a478bee46e88-2b17d2f0e21mr3130420eec.27.1767838091880;
        Wed, 07 Jan 2026 18:08:11 -0800 (PST)
Received: from localhost.localdomain ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b3c44sm9301871eec.28.2026.01.07.18.08.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 18:08:11 -0800 (PST)
From: wang lian <lianux.mm@gmail.com>
To: kevin.brodsky@arm.com
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	wang lian <lianux.mm@gmail.com>
Subject: Re: [PATCH v2 7/8] selftests/mm: fix exit code in pagemap_ioctl
Date: Thu,  8 Jan 2026 10:07:57 +0800
Message-ID: <20260108020757.45670-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107164842.3289559-5-kevin.brodsky@arm.com>
References: <20260107164842.3289559-5-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: wang lian <lianux.mm@gmail.com>

--
Best Regards,
wang lian

