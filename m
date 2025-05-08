Return-Path: <linux-kselftest+bounces-32662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D6AB0058
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5C23B21AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 16:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EFB281523;
	Thu,  8 May 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtzZg4Lh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADEE26FD88;
	Thu,  8 May 2025 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721417; cv=none; b=Bp7mHbZzbpaWo9zsFcugp+64e5qRB1/R6veA1dhrCJkLfGQRlQ/YJQgZRuFLUjRXIiQMmT17l3XuZH9anraC9VgjYIsdfHgj8KN0JENCDrX9mZH4207d3a69Lpuq1Gy9jSuES10p7h4J0MeDcsrMTW8+OhwFiys/qW7LOpiff14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721417; c=relaxed/simple;
	bh=PDpqQ2zJ1+LUD54W62htaI4grJde99p2dmKUmlaO2rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XewxDDA57zmaQAEtOptzqqaWSRqt4qMdj/yODxz+WITXQh97o3RffIIP0Is0xHZyoi8oXovpMJF1n68CvlGXQTS4J/bohcE7yvv/YzvxlF+TX2CN4CMl2ieVtHc0TXK3jBpU/Pcd8jqfKwbpBvGlAWbn4gVS+y2aLHnGkI9wBuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtzZg4Lh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c33e4fdb8so11620945ad.2;
        Thu, 08 May 2025 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746721415; x=1747326215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDD4axKNwOug/15X5rmrMUOmST9IPUNgi9stIcbaCFA=;
        b=YtzZg4LhmuBZ7pqO6qgv4uobUQskWWFLmLJU2vYzgKWHyyuOhvaSjDbRtFpipewEIv
         elEJiKwkCWx+1bVwrlkZ2U6nSfyH98OoivylxYvNDMS5Y4RqoA3y3grHxfp8ub2rO2tI
         VNwjl8BZt+MdFLdp8W2+ucj+lYu7smmP4XHmZjJ2abBy3BW5gOTa0gFMvttpdFP8k+Nz
         MXTGSKUmreJTAa5aGO1gEPDRfhl5NgmNB6QBuVYrH7Z5u4kqHA1ud5hDihsHg0fwqPCQ
         19KPzSZ1JuFjq2WdO11g7GD8qRYy7p77sABvL9rt91JEb/pCf0N1uLA9iAFJbPk3EQBx
         U9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746721415; x=1747326215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDD4axKNwOug/15X5rmrMUOmST9IPUNgi9stIcbaCFA=;
        b=MghoZptu33xnK1Yob2vrCOcxN4Fgp1mk2PtJo/HGqQEL1oWGeQsowsqI4h0dgVmtsp
         CiKEKwVMz+DPw+g3jwGxkXUik8vLH/kAQBtOJ0xWcCyly66oNe1Yk1jSoie1neoyMjd9
         ffCgnvkiKa0HAPMWHVD0TYkxQZls7SflgJ6WMv2rYE6W2VQ7rS+VJOlJ4cjuK0jdIxMi
         JonPX14IUS1IOQWYmL8mhhyUI+FrtTyEMCLl811/y0kAHUsGk0mY48HIU9yKywgM3CM6
         yzsW/K15R3CCXIkPrbOHn7MIGDQJL56w/PnFGMYqVoiG7wb7DaYn59QRmv32GABkZLbC
         TMKg==
X-Forwarded-Encrypted: i=1; AJvYcCXN3cndaN4h5ff7EV2kxrSmfvDrRdYaghb2aPVNUf3+VNfywc9is/7aNziq/ir/4WDUUBjw083B9NY7BrBndFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyMkpU9zPBZ6QExR/eQ5xwhfR6jtGBm175FPbSPbjJYoTC67xd
	S63kUrMxk0sYKSPNxo5maK5yhKUsO87E0zDBJHX/WSXQzuavNb0=
X-Gm-Gg: ASbGncvZKV//6G10PIj2/ZoFvvsDHIZV7/jIKPOlmwI8rv9a+7+L8Xb6El/yhm/9qeg
	4lPZfifS/Jp6CqeaMahDQVEmpxXz9ADYR2SUKvh/O3nieD9eVrID6iC3byh1uVXCCQ/SJsb4rpA
	TzMpQsTMBV5zoriKcIuCH6RGx3ory/TJJyOHpzOyUGJBW/abhccZe6SI9dv5LBseT9pB6K/T7k+
	eoP7j5uSu4A4uwVQNcN6yVJYDpV5BN+bsSfdxLTM+bpwj3zrk1NWAGkFAI2HEfuQIOAy01ETINq
	bShBa2SB4Rku5ldxeqiKs3O2EHxpmkOF+HgEle5FSRG+T7BnDjN/enmKiNLSSBtYv+4yDQSvOtq
	yNA==
X-Google-Smtp-Source: AGHT+IHUjQX5kcIE7/SgjAj5Yp9UlVRdDjfbF2VZJDOPZZtqVNafMYnOLOkiKucPdqFZ6hc8H7Dv8Q==
X-Received: by 2002:a17:902:e94c:b0:220:e338:8d2 with SMTP id d9443c01a7336-22e85ce9aa3mr66088015ad.21.1746721415456;
        Thu, 08 May 2025 09:23:35 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc7549354sm1322465ad.32.2025.05.08.09.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:23:35 -0700 (PDT)
Date: Thu, 8 May 2025 09:23:34 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Joe Damato <jdamato@fastly.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2] tests/ncdevmem: Fix double-free of queue array
Message-ID: <aBzahvmKEiwHwciQ@mini-arch>
References: <20250508084434.1933069-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508084434.1933069-1-cratiu@nvidia.com>

On 05/08, Cosmin Ratiu wrote:
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
> 
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
> 
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

