Return-Path: <linux-kselftest+bounces-23846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EB1A004A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 07:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E741883EA3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727221BC099;
	Fri,  3 Jan 2025 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fv3QmmTB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6691B87EF
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Jan 2025 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735887500; cv=none; b=HhrRwPJ3v2zeqZjK7K8gqXlzA2+OZfyCOpvXXogkTp1QdcJY9enLtMMJlFJdbtVNMuVfyDqGwP6fmu3hV7+bWhbU7Y/0Qf8gs5Q5UbuovgWL5h9uAvAguEq2yjH5DiAVQZbnWCiS81T9a9SGSn6LkNxyQanuRemsrSC7Sjq0ycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735887500; c=relaxed/simple;
	bh=uZvmFNXraGxVUvTGYtVZ/ME0RVp73Xzv7aLP6o5YXhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uycm5a9FN9PMG3kZds6cdKQHgDQHbVHJ/a4qcbDieHpJHv39HsnLV9v5qXIPKP32dT3S2zsbzKLpcQuWj456Z0pGrsvvIdfH/+nhP1TIqddDjsKGw8WOvyhxjBLpK81rbvSoyLIzuktoBNc42+lPNyF5YcWZ7vIsloiM1UgbAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fv3QmmTB; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3862b364538so6841710f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jan 2025 22:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735887496; x=1736492296; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uZvmFNXraGxVUvTGYtVZ/ME0RVp73Xzv7aLP6o5YXhc=;
        b=fv3QmmTBlD7xvvE/GGchQPWnfhzKrUhqj66OtzmuQOn4gn6E1t7DLZSEblLdIKQ0EB
         yQbUje9Z7qCxxV4n2g15ST2H1elW7XVOobPZnz2WhJk2X2FJdgmW6vOKSjN+mH/fOl04
         yM/eCO0Q2E8j5mdXIp+36LyTowi492so/VAxMZbS+FtA4kXcF5k4yXE5YeglfLYPYq6n
         cb63T0+0/lS2+TBurO4PQ1hzw+y0ZF1pxJd+tH2UlGqjxECbQHNIggJQODV2FM786kFo
         slOW+Wb0ZY2CKPHJ1PFiRt1GMV9XdjjVSthhWzaITLlGJkkT8GrY3Rj6BQnUqlGmaKet
         tEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735887496; x=1736492296;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZvmFNXraGxVUvTGYtVZ/ME0RVp73Xzv7aLP6o5YXhc=;
        b=c1jKYz4bfUaIO3XWBeVpV7egchNhLJB4Ra35vCAsrYVDYQxUN0uQ1ayNos77s6btR1
         L6F9Fo/FOlU8UDXsW0b8XbdtPZZdWW3LR9h+MzrH7uYzaQH4guwEMY97FIzYsLL8Jveu
         urD51Y7FQHVKvafgOXlI347gMGVGmCz7v5NVv9kYYwFdVslcy9F2gk0r48PbeZTlWXdf
         FDnShnOZgWHV3As+D1drFlUmy8vSEbFlBJo8Kt4CiPDvk50rm1I7jYGJINWFVre/hHGz
         4FV3dQxoRLAqKx7WOnrl3uvWP30S1ZTX6FVtB1fbY5QTi56kEYlWH4adaUN+tszTrrPu
         IbEg==
X-Forwarded-Encrypted: i=1; AJvYcCW18rEb7PbuED3oWTZ5WymLYdCqEY9equwsYtfmb8XRZZEriAIBEdLZdWnHphqlrZZ2K3+cg0YAzIdAJu0oYE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqN/KTTBd50OsMbzxDiJWoEWbgqU7DcAQ6ny+20W+bDDRpdwbp
	YftEobeOEIv824tWey7ktm0uO/sm2Ofj3NGRjEFlRcUcxsDvYVlbMsXVQZg9DAg=
X-Gm-Gg: ASbGnctSuz8YK1etuUxUmEj1NL3kDUMQH0kOZv+OuDnP5HWlE1ZLYbcGSPfjsxtHt8T
	chUDJZm45qY7wuZplRsbGjdPhF2mNIZIqWQCbWlGXnC8ZRoL+VgmXhLJgJHSTiQl2VWRi1aZcjy
	1vpcBxk1C/ndqfGeubE8pH0BkP3aEtR3sOjedWH0DktKiQNzsTxe2EjLmp7Lr+P3gy1VZPElDpC
	17WQtTGxq+8pjK8mqiGOXYb4oT8GjylV9SvBbp/2VMAPbCy3wUxcCTiI1xn5usBzjyfiW/WfDy5
	aHpSQIUCxfMHFTBCKh7Tiw72Gg96HbPbjl/Xii7dtHOMyrC5TI0mJo5GQ4RZ62hIkNG85F5EJbn
	mzN72Yg==
X-Google-Smtp-Source: AGHT+IH0GAtrEtOzyc8yCFlj/GI2tQ+enhDK8ABHkVTraKDu3aontF3mFgvrkrxtUKrD1XyGNRWMNw==
X-Received: by 2002:a5d:64a4:0:b0:386:374b:e8bc with SMTP id ffacd0b85a97d-38a1a221d7amr44309704f8f.15.1735887496434;
        Thu, 02 Jan 2025 22:58:16 -0800 (PST)
Received: from ?IPV6:2003:e5:8731:2800:842d:42a0:5992:3595? (p200300e587312800842d42a059923595.dip0.t-ipconnect.de. [2003:e5:8731:2800:842d:42a0:5992:3595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e219sm40466083f8f.84.2025.01.02.22.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 22:58:16 -0800 (PST)
Message-ID: <9878d90f-faf3-4853-9a79-a21b4f58ab4c@suse.com>
Date: Fri, 3 Jan 2025 07:58:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
To: Andrew Cooper <andrew.cooper3@citrix.com>, lorenzo.stoakes@oracle.com
Cc: akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com, bp@alien8.de,
 brendan.higgins@linux.dev, da.gomez@samsung.com, danielt@kernel.org,
 dave.hansen@linux.intel.com, davidgow@google.com, dianders@chromium.org,
 hpa@zytor.com, jason.wessel@windriver.com, jikos@kernel.org,
 joe.lawrence@redhat.com, johannes@sipsolutions.net, jpoimboe@kernel.org,
 kgdb-bugreport@lists.sourceforge.net, kirill.shutemov@linux.intel.com,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org,
 luto@kernel.org, mark.rutland@arm.com, mbenes@suse.cz, mcgrof@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
 petr.pavlu@suse.com, pmladek@suse.com, richard@nod.at, rmoar@google.com,
 rostedt@goodmis.org, rppt@kernel.org, samitolvanen@google.com,
 shuah@kernel.org, song@kernel.org, tglx@linutronix.de, x86@kernel.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
 <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AdhG8ToVhAfNI4L0hQ66iNcN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AdhG8ToVhAfNI4L0hQ66iNcN
Content-Type: multipart/mixed; boundary="------------3WUDo4UJMp9BYldWFyaC18GU";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, lorenzo.stoakes@oracle.com
Cc: akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com, bp@alien8.de,
 brendan.higgins@linux.dev, da.gomez@samsung.com, danielt@kernel.org,
 dave.hansen@linux.intel.com, davidgow@google.com, dianders@chromium.org,
 hpa@zytor.com, jason.wessel@windriver.com, jikos@kernel.org,
 joe.lawrence@redhat.com, johannes@sipsolutions.net, jpoimboe@kernel.org,
 kgdb-bugreport@lists.sourceforge.net, kirill.shutemov@linux.intel.com,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, live-patching@vger.kernel.org,
 luto@kernel.org, mark.rutland@arm.com, mbenes@suse.cz, mcgrof@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
 petr.pavlu@suse.com, pmladek@suse.com, richard@nod.at, rmoar@google.com,
 rostedt@goodmis.org, rppt@kernel.org, samitolvanen@google.com,
 shuah@kernel.org, song@kernel.org, tglx@linutronix.de, x86@kernel.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Message-ID: <9878d90f-faf3-4853-9a79-a21b4f58ab4c@suse.com>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
 <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
In-Reply-To: <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>

--------------3WUDo4UJMp9BYldWFyaC18GU
Content-Type: multipart/mixed; boundary="------------63xrDYqOCLn00LODgHDKUWxX"

--------------63xrDYqOCLn00LODgHDKUWxX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDMuMDEuMjUgMDM6MDYsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBIaSBNaWtlLA0K
Pj4NCj4+IFRoaXMgY29tbWl0IGlzIG1ha2luZyBteSBpbnRlbCBib3ggbm90IGJvb3QgaW4g
bW0tdW5zdGFibGUgOj4pIEkgYmlzZWN0ZWQgaXQgdG8NCj4+IHRoaXMgY29tbWl0Lg0KPiAN
Cj4gRm9yIHdoYXQgaXQncyB3b3J0aCwgd2UndmUgZm91bmQgdGhlIHNhbWUgdW5kZXIgWGVu
IHRvby4NCj4gDQo+IFRoZXJlJ3Mgb25lIGNvbmNyZXRlIGJ1ZyBpbiB0aGUgc2VyaWVzLCBm
YWlsaW5nIHRvIGNvcGUgd2l0aCB0aGUgYWJzZW5jZQ0KPiBvZiBzdXBlcnBhZ2VzIChmaXgg
aW4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVsLzZiYjAzMzMzLTc0Y2Et
NGMyYy04NWE4LTcyNTQ5Yjg1YTViNEBzdXNlLmNvbS8NCj4gYnV0IG5vdCBmb3JtYWxseSBw
b3N0ZWQgeWV0IEFGQUlDVCkuDQoNCk5vdyBzZW50IG91dDoNCg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDI1MDEwMzA2NTYzMS4yNjQ1OS0xLWpncm9zc0BzdXNlLmNvbS9U
LyN1DQoNCg0KSnVlcmdlbg0K
--------------63xrDYqOCLn00LODgHDKUWxX
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------63xrDYqOCLn00LODgHDKUWxX--

--------------3WUDo4UJMp9BYldWFyaC18GU--

--------------AdhG8ToVhAfNI4L0hQ66iNcN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmd3ioYFAwAAAAAACgkQsN6d1ii/Ey+c
fgf/UYpXMGX7CcsGrANTtlW7HBt7eur3Q96rFTVnTBejNHfIm/TemXv9C9/w5NhEcq9sqmeIDxOe
8DTdPK/EM5qfS06x4EFYjxdJgORMczX4P0IvRZHJY6T7hojulK2dyumKZNaCPY1ceUV3nERaBWKl
csa1KbWcBMA7uMBCl1w8M8aL3+0T0UBDu3oV2jUGR4dKJdaHqRqGJCZKE2pztzSGmiboOTfmOnr2
CxpyEu6JVMTl782cRiOS/KfVmVWY8jfA0D14iopSM0cKYF0W9Bo2XbTiD8Vp/pCCDBDOWlllYtlC
c63hcFoml+h9kNfEU4Yl4H4kAWki0dCgwk3RbXj3rA==
=xSk+
-----END PGP SIGNATURE-----

--------------AdhG8ToVhAfNI4L0hQ66iNcN--

