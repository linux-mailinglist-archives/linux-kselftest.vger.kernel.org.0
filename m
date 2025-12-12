Return-Path: <linux-kselftest+bounces-47464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B3CB7A23
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CE39303FA4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFC2874FB;
	Fri, 12 Dec 2025 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzpMSyB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC247286D64
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505353; cv=pass; b=nbV1y+hJ4ZFUNRYrz2gVyckUSCyI+jjw3cC8zY+RVigAxJSHDsnvz4gM1wRZpZgpOIWajavBv7f/TLuPc3bzpjYRrnVt7hjtz7MoMDBLDUKE2qYVwM2YGL2ObK4TdCA/FlGgbc92Ga7c6SPwRQ/RenTuF6HwGty8UV9+K0x6Bj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505353; c=relaxed/simple;
	bh=84TfbL9BjJfn33I8UDW+Ory3GlE3i/ue11dFxydhcZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+u98HSUFVhdo2REvLVaeUlR/OLzVAvCPWKBQP6Vm77A6QMyAN8gwQ4lvpk6QOQf2pJAREj62eLMaWwzam9lPVIJffAvQp2LUHQRsATZmyiyusxn/YhbWdaHmPCfXgvQQjS3bToIbDFifreyiS4lwaGgltruHU1UGtolGQCHxMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzpMSyB4; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so129365e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 18:09:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765505350; cv=none;
        d=google.com; s=arc-20240605;
        b=h+gJ5gIZ3R82AL69xRXmiuzryi78oTnNsIUmX8iGmCUDFZBlhe6kr6wjsNiVKBaiYl
         5yJylk5vAD1Ktxyyyh1WJ0NUn5dir7mI7a50+yfUQXTRX93Vtd4HlREfBxcLYwB4TMsY
         xCjp5Ag5tTA4hAu7sTx6oswvfJqT3TMJEC31cbhjAeY3PX3QjcUBPfBUja6d8MoR7DKE
         0O7P/Byu3/gbIOyVcNZdgMv1MqGAYAiM5x3Lo+nnHmjFndHQVmoHxjrVgxEiyp9YrO4e
         nvQS+Iae8YcFgLHxkILNh1/aH0mDw0O/4P+6+1LmZkcnTYrIYwyajVGB3mvRVelL0Nfq
         uC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=84TfbL9BjJfn33I8UDW+Ory3GlE3i/ue11dFxydhcZo=;
        fh=2YnCzX2bf5PLUfW35SJJu8sHBuxS8XythWvXuZQ7FkI=;
        b=Y7wdnQqkMOSRBiZ7Hfv/N756VKA+7l8wgHPBcBqNe2o+7wQ43Zu/SRnAwuIOwE0Wuk
         6tkulgzJyvUs/hnvrqieuY6InyPq3lwOjujHs8JipHqIAmf8c4UJtMM6AzcmJGY4C5g9
         +KnYIc/9Mxjst8JAfcp3etIWr1aq9hZsVGJCY/rYFZyluHfGwsoMHAeubDLDX2eYJem3
         w+jIB/C0uqRKRlUMTuJ+LTUNTH6Avfct8lLtlcLFXfnjbWNG5eUZZ1rGALoBlPzo75qO
         gbh4/gk+/CRhgARbPpdHmv3Gj82GgD/smYIHUInCAoQJ2sJBBrzAF8ZIrFZBcJyvNdOG
         R5PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765505350; x=1766110150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84TfbL9BjJfn33I8UDW+Ory3GlE3i/ue11dFxydhcZo=;
        b=fzpMSyB47IpwvL3x6ek959n8V2VkIas2qmD7BY0wjZyOgygyjj1H524Bn5h7PBNWzv
         /DS1xPcwzc4LH4eamUMpk36gNNoAoV97F8Tfz451sOjxTcnDQO6U/09Xe5cmTr2l6gPT
         4iT8e7Ds02jgagpMD4IQcCOrCYb/ssir/ponM5ofYyvQpkyMmN+0s/+Ok/elrbjnGmhe
         xFLUPd5zOajMAJzjW8SfnqoiRHv0QWLBBc7cySf6P2UVViveV8/nSClmS4EJ53haXdON
         qTsyo2x6oFvoLlkdscW/d5UuqTrY0sZmId66DEMBgGzWTSlqRfHQdkGfItJ5s84CkR9r
         AooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765505350; x=1766110150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84TfbL9BjJfn33I8UDW+Ory3GlE3i/ue11dFxydhcZo=;
        b=CI8abyHHrQPRvB3leCjkEXoU8OOU2zlweORuROnsCw5R3j2B8ZxmUKFgX7wg1iv0cp
         0lXEBPp5/RkzUZhGxJJPSr2iuQdl7t8y0U5+L1huaVYVVz8wWqJ/9IYdyCG/jLUeV2mH
         RiW9xRg8u2Ez3ejipXBJE9bRf5MazOtd0Mz8PolFnmxnia1rBJROcF7ilP8eF77S26IB
         m4o+gfpjK0Z5SuHYUlvLiq6VHEqidstNzvM8uFcNkQDtGTffC6JbwGDMxoK3IaPW9SvP
         qEamjF1OGNs7nBS22njh+gQmvGopxCC/lMs+/B9EHI27OVCMieqdJXmZvu9upO+ZJz08
         z0bw==
X-Forwarded-Encrypted: i=1; AJvYcCW6GPDEFrQZ8NXPj3DShDkmScds7MyOTEWJdxJBMu+pDM62Opyg7YWtlbLTbbH/8PUNjz5YZuMgzw5n0jBmP6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8l9RxwXIKG/0bb7WPWAVTr5NSVl9D1VwG43TxbItA7Un+8ak
	Wouy45rXQNvHcCJZXONxcXmdcpEEajVaODQUofPlhaZtQNrvuuNfu1x9ynOQ4zbj7VyDvJ9UvUA
	RoIdX3KpX28uk8Gj4gwoRF/Ps9wzEKfZlv3GgWlOw
X-Gm-Gg: AY/fxX7JZGBGdyGeIty+mrsF38KUuunK33EQZjcyXrk7HLScTNxFii0ub3JFjz6GrTu
	tB/gqnj6FAKYV2I0/hjX65AKplnkGfHhijtk1LhSIvPP9cY+6kwe16fn/V+omCB0yscfuT/3eVu
	p2r7f6Yd5dagOSAuSavY1/+iHzwLV1p7l0DkhOOoLIsXbqySILeQyFT4296jTs9lwcGSIStveOE
	kTU7vLQ+41UORwKRDygnBJIZoVHGFrq/sicyvURb6lVWvxLrIf8udo4++KXidZSvcLDfon5h98i
	n67DvF/muvHiSaLokEY91v6B7Jef
X-Google-Smtp-Source: AGHT+IGoi5wVrkD2fWPEWoc/lIs5FT33tT8boqcMkmHzGIlAt4ukcQFeZJmytGledBHa8gl+3ojCpFp5RQ8KAJmzYtQ=
X-Received: by 2002:a05:600c:68d7:b0:475:da0c:38a8 with SMTP id
 5b1f17b1804b1-47a88d1fc5bmr854875e9.4.1765505349917; Thu, 11 Dec 2025
 18:09:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1478ac09-8134-5551-13b6-c7be096262af@redhat.com>
 <CACw3F52i_Yr+8Gd1=H=EMi7NnVJ8WCgMkaG1dSe8FD7PvOsW8w@mail.gmail.com> <c44b75bd-bf54-0aab-78a2-89f448cf126c@redhat.com>
In-Reply-To: <c44b75bd-bf54-0aab-78a2-89f448cf126c@redhat.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 11 Dec 2025 18:08:58 -0800
X-Gm-Features: AQt7F2rAtAMfq5kg2V3CkWpX1f5OFLeUqrS16Y_3ULq9rATVCLdx1UlpLQpqi04
Message-ID: <CACw3F53ZGQxefk9E8c8-9UM2o3Rv+0SwSt=n_fatBOxwQE3FNw@mail.gmail.com>
Subject: Re: sea_to_user sefltest failure
To: Sebastian Ott <sebott@redhat.com>
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 10:11=E2=80=AFAM Sebastian Ott <sebott@redhat.com> =
wrote:
>
> On Thu, 11 Dec 2025, Jiaqi Yan wrote:
> > CONFIGs seem alright to me. Do you boot kernel with cmdline options lik=
e "default_hugepagesz=3D1G hugepagesz=3D1G hugepages=3D64", or dynamically =
set up
> > huge pages via "echo 64 > /sys/kernel/mm/hugepages/hugepages-1048576kB/=
nr_hugepages"?
>
> Neither of these. When I do the test is skipped:
> # echo 64 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> # ./arm64/sea_to_user
> Random seed: 0x6b8b4567
> # Mapped 0x40000 pages: gva=3D0x80000000 to gpa=3D0xff80000000
> # Before EINJect: data=3D0xbaadcafe
> # EINJ_GVA=3D0x81234bad, einj_gpa=3D0xff81234bad, einj_hva=3D0xffff41234b=
ad,
> einj_hpa=3D0x80241234bad
> ok 1 # SKIP EINJ module probably not loaded?sh: line 1:
> /sys/kernel/debug/apei/einj/error_type: No such file or directory
> Bail out! Failed to write EINJ entry: No such file or directory (2)

Looks like EINJ is not available on your test machine. You will need
to check several things:
1. does your firmware have EINJ support? kernel should log something
like "ACPI: EINJ populated" at boot time, but it doesn't guarantee the
EINJ support, just suggesting it may support.
2. if you are sure about the firmware, did you build kernel with
CONFIG_ACPI_APEI_EINJ=3Dm?
3. if CONFIG_ACPI_APEI_EINJ=3Dm, please also "modprobe einj". If
modprobe failed or /sys/kernel/debug/apei/einj/error_type still
doesn't show up, firmware probably doesn't support EINJ at all.

I will probably add more comments at the top of the file to clarify things.

> # 1 skipped test(s) detected. Consider enabling relevant config options t=
o
> improve coverage.
> # Planned tests !=3D run tests (0 !=3D 1)
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>

