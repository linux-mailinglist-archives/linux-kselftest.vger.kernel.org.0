Return-Path: <linux-kselftest+bounces-32040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365ABAA533E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 20:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28EE16C62A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AEB25A2CE;
	Wed, 30 Apr 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3CuVjk2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4A21CFFA;
	Wed, 30 Apr 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036221; cv=none; b=qXsoc4yqb9RvspBm/0AsqnebnkurY2U+IhznUYOobfeVuQBkXytotOvzWUkz9GODhl13YBZGyuW2tPZD6DOzY4Yd6WQSYSbDvkognko5/ULOk5LscKtD2Bv7W5LQgYxUJqWesWE3dRnif5xmX7NAxa4/b1f+xJuOJoewa/MAwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036221; c=relaxed/simple;
	bh=Ejb0NJ8fiHHEBkwy8gvuLAUadEi67+nSKBvWXY0yHRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMImzjvcNq/gywxpDmyrG+0DIpEwSLU3DQdw+qOakyYJxGglLO6U7xexmf2Xy1mpZjKje+YI6ONiisJ7rUZ1kr+LiXudIWFggemxuDrh0qpcxlRFUpXI5YOlEQ/UKVk8JJvwSDXxygYwMxEw1OFo86c/eUzajp7QyBeGynMsW+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3CuVjk2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c14016868so87436f8f.1;
        Wed, 30 Apr 2025 11:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746036216; x=1746641016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGJUoJ8xmE4PDzk/3EWnD6tn1e7OqjPRCxRG9VCtddk=;
        b=k3CuVjk2RNZdzhUY50NZjzysHjX/wc9pJ6ywHGH9viVkGe/E8NtFjLJBdrH0Pq4qCj
         6X22kxIvkLPoZqatMWrttMVnGOt6tHYrlD8qYdujyZS4gis9FcL1sgE5Ev4xne75oCq8
         gue7lWlXWgP/YB5ARN0WZ9S30yVrZynfvIQNjET+1GgEzypt58VsxK2mycw7MSlOVmY6
         pyrXeMILxMAEL6myrHv2Gn34LHPnUlI6LDHceYZfBRwrYQZDp4NfI8LF6XLfybcewFAZ
         uTndxEX0ez2FDie8bPRpOQrZLPDOCaizKuVOcTvDJBXFtwNsYJ3STY826uL98WtZRn64
         +tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036216; x=1746641016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGJUoJ8xmE4PDzk/3EWnD6tn1e7OqjPRCxRG9VCtddk=;
        b=k0REhGaYQJWG3aNXEJcDGwEemYrH7bqOoycr9x2Febr6KecpbSjVGthlMAJLg+1Z4h
         l8aACKwIoz/QRUT+64deGD6bD+FCRHfDVEN6Bd1JXMpJkuNQ1twOkBoEIbk/CJe/47uH
         0S8Wep9sR/JPleaIqMVN4/mrXNEr9xuLgRu1pc/iqELddy0x8MRfHNmBucQ5z10Ogh0h
         a5IKa4GDJn5j8X6ERWw6t5pkEimxspekXliTqSblI2bMTjt3AMDQ9Ye37lvke7P0kA/p
         ZSkCfh5jB9bstXD/L4v2LciDdCsVdSTNJwROgxQ7X28VYFL2MV/WdvK48KSuy7oKOgtn
         m7lg==
X-Forwarded-Encrypted: i=1; AJvYcCUHEW3ODpsSR5zV1iRyNbA8fdl7gkA9WGZ3rbIxzz3LFXHFlgMvoQSZMI+9hEkAGNSlG46Dll3Sh2VE7Rm5F14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlPxqO06tfRGpvSz+rvOrsmfX1Hu0PLaNt+cL3so+LuzKuQit
	e7vrLdEF7Xw5A/uNI+4Bx9/9WhuXDulN+StzAVJ2STBSTY7UY2LE
X-Gm-Gg: ASbGncsUGuc6lvrgPm28DcV63K6dQomKz4oIxCiByKSi5VIwEY6Pk7s1lzqqRlXlyAJ
	kMcON7HssYVltv7VHBLKVFqTTylHbN3AF1WeNU2X7JaW7YAvsRZi3qaaVkJCvqTHd4CLlkg3J+y
	9y9zWPLWm1jJ7XKfTvL3CHs7CK9DXlWUMJToPQDsgHXfonmVV5z/cFU52kn60asBxr35N2Dzo3e
	IkPjvUMsfl3ZNqJ1w6DZtme1Tm6wmer/durHg+DailSGHyn8B2ffazmDP0aTG9KXgiRAaR7516j
	KyHSZ1HmbVbV/kJmPXpabw2WCwtVondKADku0U3/NiZ2YI099p9p0G3n51Xedm2n4AdJvbDxPH5
	ukUwgM8c8+OM1e/gieXb/hRoRwqio
X-Google-Smtp-Source: AGHT+IFjJeSbos5bpBX1n9JarFK+la7nH7HaEQ0UjixxnIA+A6hJXmKCYMgWefJRFcCGgV7IpEE9uw==
X-Received: by 2002:a05:6000:178d:b0:3a0:7b07:af9 with SMTP id ffacd0b85a97d-3a08f7bb221mr3856085f8f.56.1746036216132;
        Wed, 30 Apr 2025 11:03:36 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca4f88sm17207861f8f.29.2025.04.30.11.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 11:03:35 -0700 (PDT)
Message-ID: <2e16fc73-e272-4277-b232-b912c84f5d4b@gmail.com>
Date: Wed, 30 Apr 2025 19:03:34 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: net: exit cleanly on SIGTERM /
 timeout
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, petrm@nvidia.com,
 willemb@google.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org
References: <20250429170804.2649622-1-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250429170804.2649622-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2025 18:08, Jakub Kicinski wrote:
> +class KsftTerminate(KeyboardInterrupt):
> +    pass
...
> @@ -229,11 +249,12 @@ KSFT_DISRUPTIVE = True
>              cnt_key = 'xfail'
>          except BaseException as e:
>              stop |= isinstance(e, KeyboardInterrupt)
> +            stop |= isinstance(e, KsftTerminate)

The first isinstance() will return True for a KsftTerminate as it's a
 subclass of KeyboardInterrupt, and thus the second line isn't needed.

