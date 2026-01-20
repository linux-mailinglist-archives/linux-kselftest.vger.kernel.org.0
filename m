Return-Path: <linux-kselftest+bounces-49548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHNqO/zTb2mgMQAAu9opvQ
	(envelope-from <linux-kselftest+bounces-49548-lists+linux-kselftest=lfdr.de@vger.kernel.org>)
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 20:14:04 +0100
X-Original-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C568D4A194
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 20:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96CB08A5AA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 18:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210ED453482;
	Tue, 20 Jan 2026 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EtsHtceN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF44534AC
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933517; cv=pass; b=YwOW283PC0k0GJ0+4605mIkTZhsyv/WxCqDMuJexyf/sPlj2vc0fxpFClArrQKoyhSHe+Dcfy4wLuAKCCu9AoojTQ6cBmbEc6jY2ogxOMnUYm1eN0JGVqG2mZ+BpoMOhKu6O+5Oxw239yyCedC7O5PA1MSHpiS0IHk3qyteKHt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933517; c=relaxed/simple;
	bh=yJ0/In7PKFw5egPEyuwjNNrSDESwA0aryCjQTpVL4/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqKzw3yVdnndfqy9zFmjwukyD+3D8X9ZCJO7nv9qc8mHzGjr++dri0mqtQXS+ZXSnn9a/QS9QLF0QK72uebPryGA4d1hRbYK20myvYlFSKRfb3qJiPK30hJtkNhKGLMe5KzJY4yqlV+7CYLtAaDDxBb0lmNfBcVfbUkbFtdKgEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EtsHtceN; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b30269328so555e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 10:25:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933513; cv=none;
        d=google.com; s=arc-20240605;
        b=GVaFpquLPC/82EL0YZTo4dlzD48O2RsVG3ejFpGIwttSWZa/chOabqHxocnrrSGrQg
         YtycfEtcErz7JBOIBSVizCwLMAJA/+93uqI1SVV1RQ7j9Z5Pe5JehSbFlF8wV74S30zx
         kI9adT1jh8qmOLsjQAIm7kfahCSiIIVAuZpcqlcl8SoV9ZUWV9pYG4alXicZDfM+hYjW
         DmxSWZZQ5Ohww2U2jPWuf5E+9igTUKnVR01PJeOWi2LBqHzAb5sQN4/SRWCliGv8eGha
         1l6iWG4yZKx6BiklAod1Cgkq/xb3gVC6Ei/z+nMC+RCdDnFcqZK/f8hLuiCQMFHeTkyr
         o5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0bGf+EPs2Mxct7IR1oXsdqnd9aw+j/UU1sitKcLm+k=;
        fh=MplThfE6w46oUv8XWF71hibc+4rjkZ0aqjEeZbFlC9I=;
        b=CiAK1y7qooiy0noOkoX8c157Ykc6RLSsXOF/0VFDQpvnunlyKz8k0AaWoaUp3ulD6X
         Exfijxi3WqNRTAevYC0bN/XGNrYt2WWxnP1g28ZCaZmrVWk0LdUh8YFhGn9EMUPa+Zed
         ov7WbPJstK8V8RCJyyAgraIp/OTF9h15ZO56sV2dHtqTnCLuxn5jD0Unt1pP8GSZN2zA
         kfwLhCFwNFrwKooh8RB7OcJwEmknUkvj7s+F4r3DQmJfq3n9HUzAwFKdb/kmB98c3nz9
         ew4yhjOimCQ8eld5XGIZK42089vRacKLqdzuInz6exhVr7vn8j3oH73jKiqQjoEeFw1Y
         UVzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933513; x=1769538313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0bGf+EPs2Mxct7IR1oXsdqnd9aw+j/UU1sitKcLm+k=;
        b=EtsHtceNhWsBdDFjvivwOOSmGNNR4KHXc9sTTEwNZRKUc1qg58PKxLNjPVkQy9m2UV
         wxGaKARZpQw/JUfA2WKr2ai5H47KSVpEVUJyPH47pWK+QDp9FrrcrQJXzJLS5f8jMTfj
         3Ss4XXMsNZdgekRKFSpSkV7yenbLE8mmt1qfvmBqcCBR2jk1Pc1Y65jvz6e7NEmxa0xR
         ekoKomxikSm22M2VSD76P9ICrttC/8sNtDtL7UcfZdrxB2HnUCsiOFDExU5rJpnZiyMi
         7eKoHJLqwwad3rw3lxK3+313+tRxiD3WZrhcUhWQVhYo/jl+YOoFmO9Gn8psJK1caZCL
         Qctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933513; x=1769538313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0bGf+EPs2Mxct7IR1oXsdqnd9aw+j/UU1sitKcLm+k=;
        b=PgnOOGs3MaN4Dem+0cEfREUcwBE0nGv/4TUXvCbRkombmG4uZiBHFRbVp7ueK6Z8nf
         EtR+P4QfpcZdpT9CTYmW4DQwDjT/swuo/w8SdW9UxsC9Pd6WWxrYXStZxm/WPxZT7g/p
         kPFQ5ThVF7q9xVp/iFMB6LIa0QvsVbynBB6hrkThnCXWIM5ZQhDBM3hhsOjxovG7mYUR
         IRkf3lZqPfZTVXGTM5rrkqjaAzQbLYB44jhqHIVwPd0zuakHBaQSZr9vUG0FMo15xZyB
         D+jO4Qz4EjvzMdp00rvWAT/XM9P+sEnLYPcUA9zlbj0R0wG8RJfogjk7RH5NHovvl901
         dCHA==
X-Forwarded-Encrypted: i=1; AJvYcCWo8RqPGh6xejZ7KvXEjT4StaGAeZOFLCjsfquTV/RdXKGSBAQ/jyai8kMiyH9iH7ReYaGnE+aicCQ+A+nWx4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4OGhm6H2ohK9J5NumR1KQSCfMo3cT5clhys3hgg6gEatvhv5
	FChioz+tFtvBCuCSuh3UC12ZtN+Zt/x7i9cgrKso8RjO7z2nxCOorvy65AzuxlN/3ve/3WmNR/R
	dAYZeGWDRyZ7STlV5vo4jPOpfEz1P9vbkR+944j1l
X-Gm-Gg: AZuq6aKSIp+nAFW0IsC6aq/WOah2M5cC/WgDbLLkPC+omwpCOSVvSyPBSOfxq3mDVfd
	4lRuCOUbxCwQfVZLzfJmIbA0X7ouVdvvEW21K2LKZfZkRCDZeAL3gsGdTR+h40veggKU93F/0/2
	H9lknBTVkNRjAzqVBT9/nJw6/bGlCu1n2p3S62ShgXHQXNFApyZzztsuB8s9nb07uIv8tHNjYU8
	ANlv7leU6RlA6tdbTVPtib9LYhjD2QM0f117Z2DNg3fOLkk19vt3CtfGujoeSftFA5Bct2oWDJV
	X1yRJS3MCvrMF9PRdStAaZNekviip09X7lbh
X-Received: by 2002:ac2:5b07:0:b0:594:43e1:ed43 with SMTP id
 2adb3069b0e04-59dcf6407bcmr6194e87.2.1768933512653; Tue, 20 Jan 2026 10:25:12
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120180319.1673271-1-kuba@kernel.org>
In-Reply-To: <20260120180319.1673271-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 20 Jan 2026 10:25:00 -0800
X-Gm-Features: AZwV_QjuNTma8hpUk4wIaGd2eIbRoiLwDebyhcOY8hqjW_FSBhmx4mg8QmbbW34
Message-ID: <CAHS8izNS7cFxVbCQOTrsfNvqFCPm8ieu-vX+fMJ1rzLaK+C2SQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: fix missing include in ncdevmem
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-49548-lists,linux-kselftest=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,linux-kselftest@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-kselftest,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C568D4A194
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Commit ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
> recently removed some includes of limits.h in uAPI headers.
> ncdevmem.c was depending on them:
>
>   ncdevmem.c: In function =E2=80=98ethtool_add_flow=E2=80=99:
>   ncdevmem.c:369:60: error: =E2=80=98INT_MAX=E2=80=99 undeclared (first u=
se in this function)
>   369 |         if (endptr =3D=3D id_start || flow_id < 0 || flow_id > IN=
T_MAX)
>       |                                                            ^~~~~~=
~
>   ncdevmem.c:77:1: note: =E2=80=98INT_MAX=E2=80=99 is defined in header =
=E2=80=98<limits.h>=E2=80=99; did you forget to =E2=80=98#include <limits.h=
>=E2=80=99?
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>



--=20
Thanks,
Mina

