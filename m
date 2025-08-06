Return-Path: <linux-kselftest+bounces-38344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3CCB1BE66
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 03:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48AB1887A54
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 01:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DD17A2F6;
	Wed,  6 Aug 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4UlhDjG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5B51FB3;
	Wed,  6 Aug 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754444670; cv=none; b=P31iH+TUZy10yJhb9I9MkKlE6O027Ztt1LBVfodyuZf0OPBMmvhLtd68ybsHwh+6H0DN4JblNsVBwjIsdazQsSC2KAgASvKToe+NBQnxhARhSkc0X2/Z3gRljYeDHhItGC7n+uf/j3cVCko0cEUU/iYTI5k06tz6QRKzREd/MQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754444670; c=relaxed/simple;
	bh=w74FIGq0AXw75gXfOcQZe3mmzfSZaThuFNuCPXvRBdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxD0Ov2722JefuT/JY7H/SaT8tdQFkW8quy9caN6WQq3B1zMB1pfARoDJcsKMFwk+iwkjwQ/Muwzy+rWX55fKRCIOjaBdlBoRGB4RoFRjMzN/7LUzhfyi3OCGOAqnyXJaqxJyPtpozU79cNca4H9fjx2Ue7Vc04iP4sLD7Nomzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4UlhDjG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24003ed822cso36097135ad.1;
        Tue, 05 Aug 2025 18:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754444669; x=1755049469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w74FIGq0AXw75gXfOcQZe3mmzfSZaThuFNuCPXvRBdI=;
        b=A4UlhDjGlXhcQzRq2SJ7Lhg8RPD8fGDDy6cFGB573jRGdjuWc857yFjCA79JfA8ytC
         nmw6zNNjD9TkA9pKlNjB9RsW2uO3R1YTA/SiIESThUfD6p29FkRr7soIauAp5Xh1otAV
         3uYjxXU/UEWuHExBz5Sm6GYq6z1X8c8Q7NOGAqJzJtu/aPyAThhSTGq/awnfztLvWaR7
         4Rt8hacWzCUhM23WY0Eyf6AZ3Uf+rRYZUKvw8bR3NoAQaaRjcp6iOj11Cc2x9ybcVTv7
         48e8T2cf//WAQ6lRK3q3OsAwmwu4s6LzvUoNQurajZhnptRiEqrZlTfFTJFvOpDQv9KD
         IE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754444669; x=1755049469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w74FIGq0AXw75gXfOcQZe3mmzfSZaThuFNuCPXvRBdI=;
        b=qJq23P3KhlQXQFcRiOfD+mOAUrnKmbod02gJvn+s5H4/isJbTuYPm9yhZrPapVnkop
         BEj+Mn+xyw3qPHLCU78KTDfqAvVmbPMd/WizcFFU7qr+2z/8gOCPLzEr+4GO2E/79/80
         3t334heGDOcaM2Iin163CtG8gQzGXsfNTP5vweW3a1nLBd01SP34j7C2oGj338X28WxY
         vqE2KNefuOxJBTeqYdKgVoRI6p50S4CcJvPk3vl7Dl1sAIkBcIG02HM3oSrgIO26xLu9
         fu5hAj16KNQmNb+r3NBR23+OPT9LMQwqpRN3+FvXuhBpdSBymNkEmlsWYcxpoqw8p+8q
         VFNg==
X-Forwarded-Encrypted: i=1; AJvYcCUA9IB7AgcRio+wbd7tIOAIz8b3qW/wHEvx2jgqOM+db1xMXP05KkDjBgie7j5pNj048DwfKf4BBsplK4eMxIIS@vger.kernel.org, AJvYcCWZfEIZJ6ECiQD8pgQlX4p0X96G+yw799x10oSbsuu3RnhEEuyTA6PwDe7DyNaH9LzvTqaKvUeJ4lf7V0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHJXyuVvfccHEGsEw3OrzyKi/rT19OAngD8L4lja1JvLdOFrw
	fOltUKkVlSnoIbRq+fSQNChMSu8aCWW9LaaG+j5C7o1tXzjsifvFo+hH
X-Gm-Gg: ASbGnctuzcv068JZnXfDXza/faPRirxPIhaz5je4CDMROkVUE3Tyiu2CP5H3No72JOX
	IVXXk2HPF6mXKjk3ygx/aVqfjGc2FtFmwdUC7AU5HNYvbHIwLYl2+27SfAzC6vADS2F+l1lcJBo
	3qBJH+LGmv1skFXfUqX5g9SdjXSaBoLbCNgjbgL1LXSEirVQpl37c5LocgJGYwRCBqURJ3/7Tfd
	SwMGBNqdcIhzJAPyufe+tKryGyN5c5gnokVNv90AlFa5SufHelAU+RDdXPoDqSzaYo+PYytsLam
	aZm6XfBj2FYfxDqPd+vkqUG8Q9kn9ZqdIMwWlpDTLeHl5UOLvoXV2yNgf3RqcOdGJknnS9pDkmF
	vzTbij24xF170IYAQ2iyFWAPgrYeGeAYmcFfplQB7HWnhRg==
X-Google-Smtp-Source: AGHT+IF57QVaXPLLcilicCteL+bMl77C52uViQHcrH/iqr0Corkc4MbpfAiii/PIkLD6ZK5p+aBAoA==
X-Received: by 2002:a17:902:f691:b0:240:66ff:b253 with SMTP id d9443c01a7336-2429f55dcfdmr18204635ad.46.1754444668829;
        Tue, 05 Aug 2025 18:44:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:21f8:86c:408a:124f:465a:e2e4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee0d77sm17890187a91.20.2025.08.05.18.44.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Aug 2025 18:44:28 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: ziy@nvidia.com
Cc: akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	david@redhat.com,
	jannh@google.com,
	liam.howlett@oracle.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	richard.weiyang@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value correctly.
Date: Wed,  6 Aug 2025 09:44:17 +0800
Message-Id: <20250806014417.19918-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <6E5CCF4D-CB63-4E4C-BEDA-6FE533E0DFCD@nvidia.com>
References: <6E5CCF4D-CB63-4E4C-BEDA-6FE533E0DFCD@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Zi Yan, Lorenzo,

Thank you for the detailed discussion. I have been following the
thread closely and it has been very insightful.

Zi Yan's fix is excellent and I appreciate the rigorous analysis.
Lorenzo's feedback has also deepened my own understanding of the
subtleties around the FORCE_READ macro.

Out of curiosity, I also checked the `(void)` prefixing on Godbolt.
As Zi Yan concluded, the resulting assembly appears identical.

I will be happy to join any future discussions regarding the exact
behavior of volatile in this context.

For this patch, it's definitely LGTM from my side as well, so.
Reviewed-by:wang lian <lianux.mm@gmail.com>


Thanks,
wang lian


