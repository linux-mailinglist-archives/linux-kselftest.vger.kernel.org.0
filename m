Return-Path: <linux-kselftest+bounces-42991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF1BD2D9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 13:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD853A6B80
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE125DCF0;
	Mon, 13 Oct 2025 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKk2ueVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331F2571A1
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356324; cv=none; b=AmYzQ64oTcR6PnzviSMPYIolgntIgKqP2+g3ui0ptNQ3A5MRIKRnKBe1L//t76ft/kXM1ae/PWTszCULV1rTbBwhRIfJQYpHtVL8ZO5KPBwY6mx/DikpnCIh3Bm9+NAPOCWe/+JfJHvLEs6LN4Rnuf6mj0XycHcPrdF2bjZ34xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356324; c=relaxed/simple;
	bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaaFNb0dAb0lntFFBSC3/JS11hBbkuux1rcoFExrFbAj+4iHCCYQPTLs3E+SeQAnFc6jTWptdOIt/CzMCpNumQEBtnGfhDtbnHWdyNTWEa5dU1KW/CFEapELdmlEMNeFPWJKXzl6Kx1/nJb45SPRnF/1Ov0EOKsPx2tfbLiZyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKk2ueVw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760356321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
	b=ZKk2ueVwit1tvApZIico9dVeKJ4YGqAai8f3A3XZGPXVzaCEv4PIBFDLmNRxuLK6seL1Nx
	bJS6geBJF/YCIXNh/puMJgsu7D2N6oCqwpl8pPPiKdZAiSCH5qq6W0iR+Nr7tainJs74DI
	28J1R563OOYP2SwFed6Bf1sJcvqW0bs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-BSw-fQB6MJy1ppfbEOVTwA-1; Mon, 13 Oct 2025 07:52:00 -0400
X-MC-Unique: BSw-fQB6MJy1ppfbEOVTwA-1
X-Mimecast-MFC-AGG-ID: BSw-fQB6MJy1ppfbEOVTwA_1760356319
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso24890825e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Oct 2025 04:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760356319; x=1760961119;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
        b=ld+UGWwc8J+u374XP+hqE3ZpECt4XVqe53Di0m0X7rylPmP7eVZMgpcetzVcUm6gUj
         qN2bEgdFBIwLHYfhLphuKDCspB8rw8j7rcBvjdd2AyfJK8k7t62SU885BlG3v+Zi6kTz
         2cfv5OkMzg504ast6v+LkdYe4rUtTR3nY7kAVDwmipUuuYGZ1XVCEwvQN/77M7qhcOOt
         kSPTFBXGZw6/qH6Dboza3+kmGz71yG0VB96K0spdwnmYHv03mLj1P5EpAiJ6cS4VpT23
         RReRabmdrjX07L2TCk60PHA9+KbvcpIhz0AlNNHzjyupU9llsoJIT8d/l8dMdezOQjWh
         n96w==
X-Forwarded-Encrypted: i=1; AJvYcCWYt4ARSpb/oitXnZuPh4pjtQfxIPK2dZA6eRxFxkp1xCj31OZgHetIDMGBr8U4zubJqq9rCrTkVSiFMDNmaio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwayYzlkXF7hRDqqpAGzp47GlJ/mN2qXUVbAzckjr5spq1wFRvA
	kqvmb+pm7HyIOImN9E16TD7sxRPbu/ekg2XdbM8WZM21kxlvIT3xgJD5yEzPpgfBkIzOwAMU7sP
	KopMpeqDWz4kbs46GXpi5JkajvJbzLW7WmZ8v7cNJLiC+DXnCJe3TGm43EzPgtj0SzQe8FA==
X-Gm-Gg: ASbGncuFuYqJOB0lYLPyY34sFuEkAXExPpbVruRXoWGXexDH04tuZBW8hDoD5jrCFky
	MqNKAWL9kvUPPWoOipXP1OorIrNPEjklGc3P6zWr8dTA6FR/XHEQn+5yFOcVxOobIdUBgQVPR7a
	5eKEFze6sLbXilmAnwXwluvXo+hKAq9lHPx5qjYEnBV5Wi24tKu03zcrsG1axpFiDHLjE1+MnoX
	J3CpicLK7j0etJU16bkMmYD1P9lZGzyKhIbH6m0Koeu1X7BRPaYjOMNvwHvM1wOBCmnXNq2HCyU
	sPYAhVaXSG8ay0zfjAeon+uFrtxYkuw1bJlM0KSEy+F3PYkYhatBuyuexjnFMmCWjfcD
X-Received: by 2002:a05:600c:1383:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46fa9af1697mr144923965e9.22.1760356318927;
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBQpARqDOhgdRULDkvfVrdX/nnJcPItjHHJgTf6QftjMtGStmELASnMi5DCd1IOYQRiBjoDA==
X-Received: by 2002:a05:600c:1383:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46fa9af1697mr144923795e9.22.1760356318519;
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm16400021f8f.13.2025.10.13.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
Message-ID: <03365f64c7f94daa39bcc7df45cac2928af2a570.camel@redhat.com>
Subject: Re: [PATCH 0/2] selftests/verification: Add initial RV tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, John Kacur <jkacur@redhat.com>, 
 Waylon Cude <wcude@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Mon, 13 Oct 2025 13:51:56 +0200
In-Reply-To: <20250926094613.34030-1-gmonaco@redhat.com>
References: <20250926094613.34030-1-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 11:46 +0200, Gabriele Monaco wrote:
> Add a series of tests to validate the RV tracefs API and basic
> functionality.
>=20
> * available monitors:
> =C2=A0=C2=A0=C2=A0 Check that all monitors (from the monitors folder) app=
ear as
> =C2=A0=C2=A0=C2=A0 available and have a description. Works with nested mo=
nitors.
>=20
> * enable/disable:
> =C2=A0=C2=A0=C2=A0 Enable and disable all monitors and validate both the =
enabled file
> =C2=A0=C2=A0=C2=A0 and the enabled_monitors. Check that enabling containe=
r monitors
> =C2=A0=C2=A0=C2=A0 enables all nested monitors.
>=20
> * reactors:
> =C2=A0=C2=A0=C2=A0 Set all reactors and validate the setting, also for ne=
sted monitors.
>=20
> * wwnr with printk:
> =C2=A0=C2=A0=C2=A0 wwnr is broken on purpose, run it with a load and chec=
k that the
> =C2=A0=C2=A0=C2=A0 printk reactor works. Also validate disabling reacting=
_on or
> =C2=A0=C2=A0=C2=A0 monitoring_on prevents reactions.
>=20
> These tests use the ftracetest suite. The first patch of the series
> adapts ftracetest to make this possible.
>=20
> The enable/disable test cannot pass on upstream without the application
> of the fix in [1].

Steve, Nam, would you have time to have a look at this series.
If possible, I'd like to get this minimal selftest to next together with Na=
m's
(urgent) patches.

Thanks,
Gabriele

>=20
> [1] - https://lore.kernel.org/lkml/87tt0t4u19.fsf@yellow.woof
>=20
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Nam Cao <namcao@linutronix.de>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Waylon Cude <wcude@redhat.com>
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
>=20
> Gabriele Monaco (2):
> =C2=A0 selftest/ftrace: Generalise ftracetest to use with RV
> =C2=A0 selftests/verification: Add initial RV tests
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> =C2=A0tools/testing/selftests/ftrace/ftracetest=C2=A0=C2=A0=C2=A0=C2=A0 |=
 34 ++++++---
> =C2=A0.../ftrace/test.d/00basic/mount_options.tc=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0.../testing/selftests/ftrace/test.d/functions |=C2=A0 6 +-
> =C2=A0.../testing/selftests/verification/.gitignore |=C2=A0 2 +
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0 8 ++
> =C2=A0tools/testing/selftests/verification/config=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/testing/selftests/verification/settings |=C2=A0 1 +
> =C2=A0.../selftests/verification/test.d/functions=C2=A0=C2=A0 | 39 ++++++=
++++
> =C2=A0.../test.d/rv_monitor_enable_disable.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 75 +++++++++++++++++++
> =C2=A0.../verification/test.d/rv_monitor_reactor.tc | 68 ++++++++++++++++=
+
> =C2=A0.../test.d/rv_monitors_available.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 +++++
> =C2=A0.../verification/test.d/rv_wwnr_printk.tc=C2=A0=C2=A0=C2=A0=C2=A0 |=
 29 +++++++
> =C2=A0.../verification/verificationtest-ktap=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 8 ++
> =C2=A014 files changed, 278 insertions(+), 14 deletions(-)
> =C2=A0create mode 100644 tools/testing/selftests/verification/.gitignore
> =C2=A0create mode 100644 tools/testing/selftests/verification/Makefile
> =C2=A0create mode 100644 tools/testing/selftests/verification/config
> =C2=A0create mode 100644 tools/testing/selftests/verification/settings
> =C2=A0create mode 100644 tools/testing/selftests/verification/test.d/func=
tions
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitors_available.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
> =C2=A0create mode 100644 tools/testing/selftests/verification/verificatio=
ntest-ktap
>=20
>=20
> base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe


