Return-Path: <linux-kselftest+bounces-28069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB69A4C56A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4633A75F6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AB1C8604;
	Mon,  3 Mar 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaUgqaa7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B0423F36F;
	Mon,  3 Mar 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016441; cv=none; b=tloIFsxno3UwTFs2H82FnmIl9xS/TWDfT8SzDYFdH5QYao0DzqAzG3NIgjSo4SVAXyZy40/HDN6Sii84/Ge24rE8PLqwbI1BAVLP62jRWNlxd0zEiiQSB+lOXFfxEAUViwp6WW1fQY5uRuEzCkmHPhAv4AJYzadPz3QJFhO7uyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016441; c=relaxed/simple;
	bh=v8Brl5yQ4WQhto4L2yYKd8rbfme3g9Kpi8JSyVRfYqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hByur2j/Jd2VKXGPNfV69Xy5Q1zR0iAXqnN9ALJpjp7DgnY2EcATOrr2nz695RW2laeJPvxzS1PlIxGfwDQOAp8y3K7003mybZrR0YJH7L8oZgYKqGwJE+qtRloOTwR+KslBRsvsCAeDtKHlP30MvyE6qP0e43i06mfBN/j6+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaUgqaa7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so9548720a91.3;
        Mon, 03 Mar 2025 07:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016439; x=1741621239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGwd6xUM0r4PEs7C4twkbH67RpqqXDyOhZuYc7QxA+Q=;
        b=IaUgqaa7eUs9NNmeSknp/vUN1ifZyEMcdfwJ5Rcinya76txid0vena196GAVZlN8fZ
         vSsFmh+MJ7f+/Y5cNYKAj3KzPb3EQM78y+6eb+yTE/v9RDvAXaItbISHCqDmAaVIQed3
         HaI2N/l00kpnSy3n0+31hfoWuY/4nU/ncczBhJ2EJmp/HT4Fc3LqN+FPmSyfvPKHdBau
         5sL2uD7AC5Vx75kb0ey450piFmLRh/HtdOGjUBPL1gJjCc3ymPYn0MZuKwuti0zgjt43
         wRz6RDoXEiKfeDBCt7TGEMIGUl0Eg1kCE5ud67JTjFL8BryGUNCgj7pSc5jNu2zacxF0
         d0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016439; x=1741621239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGwd6xUM0r4PEs7C4twkbH67RpqqXDyOhZuYc7QxA+Q=;
        b=tu5L+1KRYJFRrvW1rKvL5z8auhDG40xhRXH+VbriDRoxQAEqR3KnDzQE2ptuXMfWi7
         sO0KJNzyLkmjGtm4blrpBaIP+R9AE2W9mXBJRC9CDu13n1hcBGpnIownvO1kouVlV9lm
         t9HGgcW/FZ6GWG9vhlcm+nlEDj+x4mqxR4rUyJSEdsXbJ3Mgij+qcBSJkk8D3tnSM7lp
         7gd6o4W+QfEsPBDag4tCKakd4Yc7kOc1Op5J/8cKR7heISo2/FEPtj/R0VkiXaCJvKzh
         h3eeK2SjFqVA7sNMfsQdu7pyQ33/u8MDUPNrZKr9hbv4hr7dWig4vrK+xoQNJk0Ac8uD
         Ck+w==
X-Forwarded-Encrypted: i=1; AJvYcCUBohcjQ0eyGeRqmp9V+b0wIuZpxepk4JAXHzhDuMRldaUIiJGk+if8z5fTIt7LwGiGibuG25wQ@vger.kernel.org, AJvYcCWzUYiV1TJy3WsODlXXxnJG8jTw977V8qRuc/wO7dimtKDCRcEgZLYj/1D9SDPhMmeF+ZOcK/8pXcte7VG3MNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQ1lPNm2JbpB37490dVx0qpMhUimZtg5T67adnJ4S1CNXUJ4M
	/eZlSKLhZ1gIEA1DOcIIv9bbNUrYvPG5dEvhWqiNzG1vWQ5DRAM=
X-Gm-Gg: ASbGncuiX20yqVXQqzqblWX/X9vWTAeDBN0khN+lsDShfntLpO18deug+A9+wo3HCgq
	HyYKHRydrn8j5RA3pQF/nWUFuvUQ9KNsQ7JxTi0/9cpNiQ4PwiMPCbKFCm2xTnW+08KUf6FMFjx
	7VpTxO/hBjRVR3LixkDXvXP6X4BJkpoF0xxYbpxqTUkrbQhNfh5cpzc8CHERtsl5ft7rDyq7f9P
	uMPS/WIYdQlAYKoX02Vj8JbT0fFUoNLp687jTxwMAiun2/1RVAXFR569Jpor8Sfn9C+14QP0Oia
	kDliRJJD2jwzJD3XGQEzNLxjXTS/L2c/noF/3v9TCy35
X-Google-Smtp-Source: AGHT+IGG3yBIo5Dcd8R7th0UeHo+FznYtPDw1jL32H4Kd4U1YoX5XLpkDQPq7fTQR/zE2zZ71OJV8w==
X-Received: by 2002:a17:90b:48c3:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-2febab57073mr21679909a91.9.1741016439289;
        Mon, 03 Mar 2025 07:40:39 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe8284f083sm11176243a91.43.2025.03.03.07.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:40:38 -0800 (PST)
Date: Mon, 3 Mar 2025 07:40:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: use env.rpath in the
 HDS test
Message-ID: <Z8XNdi4hxzE3QfFi@mini-arch>
References: <20250228212956.25399-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250228212956.25399-1-kuba@kernel.org>

On 02/28, Jakub Kicinski wrote:
> Commit 29b036be1b0b ("selftests: drv-net: test XDP, HDS auto and
> the ioctl path") added a new test case in the net tree, now that
> this code has made its way to net-next convert it to use the env.rpath()
> helper instead of manually computing the relative path.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

