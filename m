Return-Path: <linux-kselftest+bounces-17162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C5096C5E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 20:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21751C24C7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B951E0B81;
	Wed,  4 Sep 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnC9JJFH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E162AE9F;
	Wed,  4 Sep 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472888; cv=none; b=oxx6sCixIMR4boF552KJiCEI2Ror8RsxBkFT8PjkMv+H8hw+bD3dru2UwIm/0f5v6sEdScOunIdxeFzVwOANPKbUoHm1p1FDfGqX/LmdK4UwZ5PxHdwvc7utnlygsebouMVfqr/RuxOBqY+mhWcN0XjumEKgnIJSb86vYDTz3Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472888; c=relaxed/simple;
	bh=e0itC/l8ORY1vxm0UOzYZbPYO3+1x+eJ4hAa9b87GG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=moA4Hnml7Z+57mfFBDsziO1UA8Cl/pQVjM/M4YswkEHS7jplfKp3V4VsoTmYFZYA1NDxLXjw7JS4YGtEnUr8ngJ8DUNQFQF3hsip2R32AzTkDSz/8GtxJS+TPpitosBjiEJuT2cVzJpyXFxq75kw3fKBA7Ka1xVZCMoCqWyUY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnC9JJFH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso4615425a12.1;
        Wed, 04 Sep 2024 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725472886; x=1726077686; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e0itC/l8ORY1vxm0UOzYZbPYO3+1x+eJ4hAa9b87GG0=;
        b=lnC9JJFHxL3yFR5F3iyKb1ZUO4NPUEwc6Rp1T82w4RvBAQGcD/46crVNdMla5nXA3r
         TlhUlzKlAZqvYamF7gTJNtYX6a9Ereo5lLMwOadEmA34eRp92UtfCf5bVpldPwNdihNs
         UciwDOiC/GyqgDROXnztsYVi1P8ERKxhpSPEcI/Dih3CsT2VhDaVe+5aTXc7KRfeVrx0
         BH8YDbG/JvYLNSCB4TcLz7X85N0T9n6IVigADB/KVE70dGiANajxqVqhXc9zLHvyQWLW
         W9/UyNkvGhOiQbj3G6XMNrr3mQ3rWLV01R4nhxlgSAs/g6xBxNH85eqrauS6Dj1+tjrT
         lAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472886; x=1726077686;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0itC/l8ORY1vxm0UOzYZbPYO3+1x+eJ4hAa9b87GG0=;
        b=c+P6OgjHKrvnXn57CNdirCsfBMXk6ZrqPLu+3v2PZGP53oaBBjzeiHd2DHkSfSBmG3
         DIPp5ZeG+4dSIMXy52aPhzLOTiKSKYvYUk/ZsabENqOpZ4fGHNQ75Ksh4fdPWmveJ6Hv
         EXok2ABOnGh6uElM3B9bFu/cVkSIMl45DPyknM32jllcypz1rp2EzQo5MED6/f3lP/O2
         GOz5cUCGaf8LDpLar+7s+5q1mTdXBBFA7w4kxapzrXxjDUps5zYKVQrGOKccWX8+Sgel
         jNKspAjJ8sJkZ4oJJWm4sAGYmyZ5HKT97bxQZjJTzHgHBOeYBrRfJ3qBrUDj+gH7kkl7
         veNw==
X-Forwarded-Encrypted: i=1; AJvYcCUWYpWiWa8xkeVxXlnxUQmiRFUd95w1P8LGx80OxYaaVD+CAPqp/29TUjlUrMEsLHsXs7Q=@vger.kernel.org, AJvYcCV5q/4Prn656GEjNrZg2qVIN8bKSQbT0W7TkesLWdai8tXN4ImURn9qAC0LTvriGtGoQHnh/+G4o7aTwGg9@vger.kernel.org, AJvYcCXkmmcOtt5Ye6qmA+6Hyy45SZLX0wX+yZ50qLTyxJU5bJMtj/I09qvbiOX1OSe/FDrFm2vz2AOIjZZ/dZonSHOG@vger.kernel.org
X-Gm-Message-State: AOJu0YxcBd2qZ9eXOlosuuG7HaNoKw0fLjdYBaPkk0MSCY9iw9Hg4DIx
	T2h8jxzJnLCF9KM92ckAX91CdlNzxGh9dWLar0ctWCxgIgk5NyMt
X-Google-Smtp-Source: AGHT+IFOA5S9ZL41D7ESXarGq3JXM7szdODlLGvWURgGPa3hq8cCWJIzW8RGSayR90J/ig4Dz/SVaQ==
X-Received: by 2002:a05:6a20:9f91:b0:1c3:b0b5:cbd1 with SMTP id adf61e73a8af0-1cece5d1354mr16087939637.38.1725472885669;
        Wed, 04 Sep 2024 11:01:25 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778521165sm1896887b3a.20.2024.09.04.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 11:01:25 -0700 (PDT)
Message-ID: <20942a8e9a23e4cc6def8ff8cc59b30e18f07962.camel@gmail.com>
Subject: Re: [PATCH bpf,v2,0/2] bpf: fix incorrect name check pass logic in
 btf_name_valid_section
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>, martin.lau@linux.dev,
 ast@kernel.org,  daniel@iogearbox.net, andrii@kernel.org
Cc: song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Wed, 04 Sep 2024 11:01:20 -0700
In-Reply-To: <20240831054525.364353-1-aha310510@gmail.com>
References: <20240831054525.364353-1-aha310510@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-08-31 at 14:45 +0900, Jeongjun Park wrote:
> This patch was written to fix an issue where btf_name_valid_section() wou=
ld=20
> not properly check names with certain conditions and would throw an OOB v=
uln.=20
> And selftest was added to verify this patch.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


