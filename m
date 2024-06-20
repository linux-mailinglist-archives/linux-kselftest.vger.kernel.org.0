Return-Path: <linux-kselftest+bounces-12367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE0A9115A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 00:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE891F2317B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC213C699;
	Thu, 20 Jun 2024 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef4k9rhf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FC6F2ED;
	Thu, 20 Jun 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922059; cv=none; b=mcI3veYsGI+UO3r9Wq91J2zDoKwePV/4QjAjm8hxuLXbmdbJTToGcZ5xL0xcYvjNQV8T43DMw7zxtgjDEqP6tch31+R1gD7yM35THcWTF1xcOSWKwNHzJ+vIJU0997o/ePRg/Xe34rjeOBmCE3tqvYxiHnIPg9wLb5nZCtd72k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922059; c=relaxed/simple;
	bh=nD7Gh64ZE4/TM/osCFDkyPbha27KjLv+MJz/e+f2RxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FhDAMlzQvYVmLfhMq7QRIN+I2IwxVbyRXhbKTp7q3Xj+S5/jGHBOX0H/VgmIPpVjcBosHcGBaNI5YAVDrDIkxDtJqln8+5PNODIX4JQj8e4CQd80oydurXk3qZLfIG6JpdmMpAHHNhBVfnBg6Mui5ZCt8xwcH6Cxok1zgVtY4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef4k9rhf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f700e4cb92so12765275ad.2;
        Thu, 20 Jun 2024 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718922057; x=1719526857; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nD7Gh64ZE4/TM/osCFDkyPbha27KjLv+MJz/e+f2RxM=;
        b=Ef4k9rhf9vRHBol680ztMg4GurI3sot2WiS0lFhbGoI1FbKtg+b0kLfMMdmm851AnU
         XaNBuPIPsPpipD1umL1G3l0jUZtwvEArNaoQ4PyHEa3smCH656TUxoU6bYOAHPdx0tVQ
         4eUxhbF9vwl9U3FKqPelVKxSq5k3inPNiSndz7YFsqKp8MR/HLku18cdnxT198VFIzpp
         0ivWSirDC2zDWeRTjePhQ5Z/h37xtDnBPK1a3vRBX5NDtbXZwybB1WP2cZKS5N2/zF0z
         Y1X/3JLUhNkdtp9QcbfCKNQRb1XC/m+aAxu6IjGhFljkWEFfyODKR4a6bhka9bE3pQI2
         UXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718922057; x=1719526857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nD7Gh64ZE4/TM/osCFDkyPbha27KjLv+MJz/e+f2RxM=;
        b=bmHLLtG76XFFRpX/HVzbVaX6cfRmOa5XEAEZhooWdwfJ+1cotIxOxFIW7x2RWywbR3
         3xyJGb9dp4qH/SG+Ky3o3eN10QQX7GsIAJM7Qcx5GSyKFdGj9mXno53x7e5vIv9nt7Oh
         i2xsM29vEqCpE10k9cap9iXaAS5bMzZA5ePjLt2qRx2o+80yy2UOiEpO2ZcRL/uV1pdq
         gT83i1aReXj41HJ+y3evtBdSUg2wgsWfSCuz+9LE6d/VzsC2HOpouHWLYLy31vLOd2JV
         kFm6edBppm+UVhp/Q18ddB7Kc3DsCwVRzcyVlhGh+WO3x6/3Qv+Jb3jQ6xoQry4byYgC
         iXcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwZxydCy8J2J9XF+uzpQkDf3s5Y6UG6YtwPFQqJpBKVNSLuZLixHx7xCo064fGClsspD4cZPqF+pI+ZhvHgktsSBkX7CFSqAAnqEUVf4FHfk7iAL8uSyeTLt1O0uAtmDats04K
X-Gm-Message-State: AOJu0YyFJqlsDQ0yhdBujynNZKuwxmPXzTx4gEj8LdVLdL2a97W9SwXh
	rfG7DY31BW7sRRJhB/qDXgUnB/QVcVFcJh46GJmATIECNLCbrOhG
X-Google-Smtp-Source: AGHT+IEoLawA/MymAhHnzj/ORK1LCiQZIVW8jBF26JxDYOCHHLvFRg6DlueUYLeebwI0rEpClFjPOg==
X-Received: by 2002:a17:903:41ce:b0:1f8:4fdd:9880 with SMTP id d9443c01a7336-1f9aa3e6f26mr80642005ad.23.1718922056926;
        Thu, 20 Jun 2024 15:20:56 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f04e3sm1194315ad.11.2024.06.20.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:20:56 -0700 (PDT)
Message-ID: <929d9649b09cb35c56796b235e1f1b97aa88e683.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/6] selftests/bpf: Drop noconnect from
 network_helper_opts
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Thu, 20 Jun 2024 15:20:50 -0700
In-Reply-To: <03185ae444b4fc91a3729df1f6f274ae5273aa67.1718765123.git.tanggeliang@kylinos.cn>
References: <cover.1718765123.git.tanggeliang@kylinos.cn>
	 <03185ae444b4fc91a3729df1f6f274ae5273aa67.1718765123.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 10:51 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> In test_bpf_ip_check_defrag_ok(), the new helper client_socket() can be
> used to replace connect_to_fd_opts() with "noconnect" opts, and the strcu=
t
> member "noconnect" of network_helper_opts can be dropped now, always
> connect to server in connect_to_fd_opts().
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

