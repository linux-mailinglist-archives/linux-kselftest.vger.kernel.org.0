Return-Path: <linux-kselftest+bounces-46421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF524C84747
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7859C4EADA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E72F39B1;
	Tue, 25 Nov 2025 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="jdkvyeoz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97F231836
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066106; cv=none; b=oi+/9r7Rr2XGAJqLj4VZKAp9inmuFApRlCdmjysdWMRwoNCdCLr7kLg9wAwncRbk+7Jx1L5LLoIT3cnHZxjtXUBh3alEhHt0lKEkwUwEaD4+6vSNaa+Who2R5QrGyr+E8xkipqKONtJasU/4L6MX4aRBF70jNapRWtqLgQ+ofUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066106; c=relaxed/simple;
	bh=+rOwk2RA33dF4WiOqSAVuKiVTIehuiVNfhftsKo0a7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jb0w1BcJB2wf06AqCEC9FVoydq5jqbl1w39Wb0U3s1FnDEZcnd5ZXejnx/vfNCA911DTJRjeNoYpX970JFBts3Wa9wI62d/DVnrLccpn1qLgGFxPp3D0kM2Atgpu2Ne/WeISPqRz2XUOp3acq5/mWCTPJtu0TTiy+PRrpEyuZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=jdkvyeoz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c4c65485so4277370f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1764066103; x=1764670903; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=usqUI61O5uSfjYi62jMQ9TXpUJFFLlygNvx27CjAFUM=;
        b=jdkvyeozp6FBewcmin2f+Ojw7B+yJhFxvgWS5HHQXq1juPMHYF4hLczdsOYn5hGQEb
         dRKDsvKOaC1royyzmAHsONXC3Jl9t2JLdKaSzGrWsIssbzPZD9b6WtN/RKy05AQCr8Y/
         sxjBFY6RZUKHkT1a04HrQVp8DgHfDE6WZ/OC3TZ3VWwxxHWtyXKn3NSBrVWg4mv6+aOY
         trgcjCUglASxEQSRiBsIhrMepSHFfo+n72s82o5w1xrxK64gDNN5V34iVJ1mkjqkG+UN
         1FW+K1M6oeEpLYceCRgtCJ5toQVCPrwaa3dZgCZ1ozzc3R74jwkklXn5nRqiSXHiJCfV
         xjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066103; x=1764670903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usqUI61O5uSfjYi62jMQ9TXpUJFFLlygNvx27CjAFUM=;
        b=E395KoErVjD/seOKI1SXvnEZPxespxyv2sC3+E0irw4IZZV1JeOUUk1rOyir2jUypY
         W8ld4/l9wPTOOddThrm2G3encR7+lmoMM7a9wGNBLf77hJBQTr+1DD5gZa9qNoaXQ+/C
         L49z4Spj7Xl1bc46c82cphFRnv3UCbMVQLshC2pmHQoYJx+6xFk9O2z5Vr4PmSFPqD7j
         O//hP4/NIL1G/Lm6Hp0ojVn7FA5mER7qXrcvLO+/v6octPM4wG+fj5ryTXu0g3BaFYLo
         aDYtb7d6YiDk4Hfk9tUr7cSpr2SCDOxy2rebCCWhE2XCmt04IJ7TICpUAEuccmasdV6m
         zeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI0K1JddZr4ljxS/x2S1q3dSfP5uNaY1qksIclwUkREQa2Co9rB9yjMgq9dOGfWNWUa+ryTXFOx8Y2tgKu6p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjh3UCUn6FGxFY0Hb6OTsueQdkpdmoi6NytwkHV7tryznJKYEa
	ewCiqJzXxK5cBssLVDbWrfM9k8PhK1IASWcxoT2IcRga29SdmHSBM5xQQtg775tdHOk=
X-Gm-Gg: ASbGnct3fmeo6EmXLDVntpHUZG4StmDkSRPxyLvZ7W/Bs3uPVNVAn18xwSvdx7EH6b0
	fzeu89bC1ioOuCuYVWyQB9dtA8CGWLP257gf9ytglPPVcT2zDmfQlHjJ5V9CXrjgmwXD93nHD+F
	TknBQTxeVM6TeFlulsBD8KCKUdR+4/5Ptm3FxeIqHie8yPnd1AIWaocz1TxB8sC7w8AwdGC4pIW
	oNoI5oI2anTVqVdRI7sLGKB+DZ4J4+VnaU4PETUTJ0eNqT1pH+NUOf6YsqzwsjrjcQKtsVnrpHd
	45o/YH2EkBq7hvC7CEpXStMGSIm4UbcNzR+QxUU0GITgk9WWnD2Zccl1A1NkJsoELCx/KrR2J0v
	boJLUuf/PVB444kUt2HStotZQq2uMwGU9YVX2isZRcH6P6pGliSwoxP7gVKgAVrwrsihVLVGQqD
	tsqMe1LdDGkGzQ/Dnc8N+Yp1Icak8ZbaCCl8z9iYB5iBJptpJPnFRVuMLGZOAkdSzOR2Wy
X-Google-Smtp-Source: AGHT+IEKq67HVyAxXm2ukowHdBKE7/qTnckkb26kV1Fs3NCGHtrM7e7hMBSQbvVfFDTOevRhJMgmpA==
X-Received: by 2002:a5d:5f44:0:b0:429:d350:802d with SMTP id ffacd0b85a97d-42cc1d34848mr14714622f8f.45.1764066102726;
        Tue, 25 Nov 2025 02:21:42 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8c47sm34796036f8f.38.2025.11.25.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:21:42 -0800 (PST)
Message-ID: <e6a3845a7522e692fa3de69ec7f1f9c9a683223e.camel@mandelbit.com>
Subject: Re: [RFC net-next 02/13] selftests: ovpn: add notification parsing
 and matching
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Tue, 25 Nov 2025 11:21:41 +0100
In-Reply-To: <aSR--l90hvP6Fkld@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
	 <20251121002044.16071-3-antonio@openvpn.net> <aSR--l90hvP6Fkld@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-24 at 16:51 +0100, Sabrina Dubroca wrote:
> 2025-11-21, 01:20:33 +0100, Antonio Quartulli wrote:
> > diff --git a/tools/testing/selftests/net/ovpn/common.sh
> > b/tools/testing/selftests/net/ovpn/common.sh
> > index 88869c675d03..b91cf17ab01f 100644
> > --- a/tools/testing/selftests/net/ovpn/common.sh
> > +++ b/tools/testing/selftests/net/ovpn/common.sh
> [...]
> > @@ -82,6 +99,23 @@ add_peer() {
> > =C2=A0	fi
> > =C2=A0}
> > =C2=A0
> > +compare_ntfs() {
> > +	if [ ${#tmp_jsons[@]} -gt 0 ]; then
> > +		[ "$FLOAT" =3D=3D 1 ] && suffix=3D"-float"
> > +		expexted=3D"json/peer${1}${suffix}.json"
>=20
> nit: expected?

Will fix, thanks.

> > +		received=3D"${tmp_jsons[$1]}"
> > +
> > +		kill -TERM ${listener_pids[$1]} || true
> > +		wait ${listener_pids[$1]} || true
> > +		printf "Checking notifications for peer ${1}... "
> > +		diff <(jq -s "${JQ_FILTER}" ${expexted}) \
> > +			<(jq -s "${JQ_FILTER}" ${received})
> > +		echo "OK"
>=20
> Should that OK be conditional on what diff returns?

We run selftests with set -e, so if the jsons don=E2=80=99t match, the scri=
pt
will print the diff and exit. That said, I agree the current code isn=E2=80=
=99t
very clear, so I=E2=80=99ll make the "OK" conditional.

--=20
Ralf Lici
Mandelbit Srl

