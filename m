Return-Path: <linux-kselftest+bounces-18902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9546398D80A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 15:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE1D1C2224E
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1BD1D0798;
	Wed,  2 Oct 2024 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NxZRftrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7801D04AD
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877329; cv=none; b=jLLK9REN+1V+q5PiYqEjN38Nii8TKC7glhHKRzNU9Xt3RRlizQosr8c5AZFAjDZZv/HRq8QsJT5XfibjBTi3cTjjTMIXeL/jtl6Cxiv5rv1AT+1ba9ShQR6rywLsq7nEGzcDgDzyDtdkfEb6NF8R1uw5NLt+q0T11OR8Gtt1biQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877329; c=relaxed/simple;
	bh=RDpSbNQaDPalzXWgewd8bEdAjy1zCTSQo6NGuq3hSPg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufez+H+a8Km/heVLd9aJJKSWmB1jZQJ3uIsexXWp28dr9+/CvlBGXQuakq0mcpPs+vVCbxQ7AnYnlYYrB9fIXlYszmkmOPZ6GLadazyFwlk2zAYtKIKDA934m1ZGBpD+OHmdGebF3tEbAQLhsXPH/ImYkUs2KO/6nOM2+zDCBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NxZRftrh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so165190166b.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727877325; x=1728482125; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDpSbNQaDPalzXWgewd8bEdAjy1zCTSQo6NGuq3hSPg=;
        b=NxZRftrhVOv2NtWBwWxwYyKDMdscMW0QBWux+J8HoIdPM9W8prBONKxoAQr0pmJROJ
         LavHk50fRdbVyUYEdfh+toMsNdzjaXb9hO355eZRfcwiImFBL4Iu0Y91RVHIkbt4pEpr
         j39p0xESRTtJ8/hGYH39aTs0LCieaQGNvPNZJhxjak/S6stzYIOX9Djr3EJQGFpmpaqY
         hG22JWpPiOPOP2KpUQV2qxPuxsH/CXNU8JOrZ56cZcYlyNJ/giIc5XQ6ZZu/dXSHp/Nk
         JpieS4jnttMIJDvwOj18iX6SFFZBtwnqho+2e3V70ppiW93LkOFFW1nOYCly+L/pqWCN
         ybew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727877325; x=1728482125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDpSbNQaDPalzXWgewd8bEdAjy1zCTSQo6NGuq3hSPg=;
        b=rn90m7+MnBRf7wkvo3AMgnRt82OAywvr8Qd+Hmv/3WMbZJk2fzHjnfah2JfsJ6w0Cr
         58UHzw8iANK5NfSv1mKTldIBw2Y1jIBetPahivRHba4RbsiYWQ8L0rW0fbiYGJjiXtPk
         HclweTd5RjrbDu5DIWKPUY0pvQvErMQx16P++noUujYFMb6EYYr3A5vaALNw4au+ikO8
         d2ZkqbTT8iDVG7DPie4mfN01FvElLEW1VnUcDGJh71dJV2gc+7fjvQrC7wdI9p3gOAsB
         xFZqTD3JYWTmkcN9t0kBFBsjjN+8JUe+gI3WctiP+APBaQeWtWe4eo+mS7A8jr7y45h0
         MDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK4v5JRitbGC1fVBW+iP08w9f+PpXEJ2uyudPpeE7fFBqLtjfKo1jDmytgk5iWxMsDyEujMMQ5tCqZ/vWwQTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ38lfouKgUcH5MqutkCSXGjhIOKXN851Qx7Sed4uPOGgbR13L
	RhdwnF4wNP3Yc8MSFHVKiqFhczh9OgpmlKxHg7NyU10cbNkR9ITrbCaMdqzYaOo=
X-Google-Smtp-Source: AGHT+IEctmrJcjBla3MxukdSa9h3HgBV8uibC0mDNbF2CRtB14uct2W30kUOVg3kkSfcxIUeHLqaBQ==
X-Received: by 2002:a17:907:3e26:b0:a90:34e8:6761 with SMTP id a640c23a62f3a-a967be75f55mr790298466b.6.1727877325496;
        Wed, 02 Oct 2024 06:55:25 -0700 (PDT)
Received: from [192.168.3.3] (151.36.160.45.gramnet.com.br. [45.160.36.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2775995sm866099566b.41.2024.10.02.06.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:55:25 -0700 (PDT)
Message-ID: <33e18a57dedf8295828ef7f6b8daded8bd771999.camel@suse.com>
Subject: Re: [PATCH v4 0/3] selftests: livepatch: test livepatching a
 kprobed function
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org, 
	live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Oct 2024 10:55:18 -0300
In-Reply-To: <20240930093308.65103-1-mvetter@suse.com>
References: <20240930093308.65103-1-mvetter@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 11:33 +0200, Michael Vetter wrote:
> Thanks to Miroslav, Petr and Marcos for the reviews!

As the only changes were regarding bash nitpicks I keep my review from
earlier patchset, so:

Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

>=20
> V4:
> Use variable for /sys/kernel/debug.
> Be consistent with "" around variables.
> Fix path in commit message to /sys/kernel/debug/kprobes/enabled.
>=20
> V3:
> Save and restore kprobe state also when test fails, by integrating it
> into setup_config() and cleanup().
> Rename SYSFS variables in a more logical way.
> Sort test modules in alphabetical order.
> Rename module description.
>=20
> V2:
> Save and restore kprobe state.
>=20
> Michael Vetter (3):
> =C2=A0 selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
> =C2=A0 selftests: livepatch: save and restore kprobe state
> =C2=A0 selftests: livepatch: test livepatching a kprobed function
>=20
> =C2=A0tools/testing/selftests/livepatch/Makefile=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 +-
> =C2=A0.../testing/selftests/livepatch/functions.sh=C2=A0 | 19 ++++--
> =C2=A0.../selftests/livepatch/test-kprobe.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 62
> +++++++++++++++++++
> =C2=A0.../selftests/livepatch/test_modules/Makefile |=C2=A0 3 +-
> =C2=A0.../livepatch/test_modules/test_klp_kprobe.c=C2=A0 | 38 +++++++++++=
+
> =C2=A05 files changed, 117 insertions(+), 8 deletions(-)
> =C2=A0create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
> =C2=A0create mode 100644
> tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
>=20


