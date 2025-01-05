Return-Path: <linux-kselftest+bounces-23924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C05A01A95
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07667A2302
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A7719F13C;
	Sun,  5 Jan 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTXuER5U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94F14883C;
	Sun,  5 Jan 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094348; cv=none; b=AjGbfCFdbDb0CP7g1OXlAi/yo5nfNiE31SXkkY1qnUAw37KZAn6GTL68poko618rUtBLCNQUYsu04ARVTavjOGXJtxsVlAvnwhMWoVgPOIZxupt1Iyba/v33+Ax6rvV51WpvGytmnJ3JsD2+4JSg0+qnH2Ed9iAKa2KWRG/l1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094348; c=relaxed/simple;
	bh=56ebDlc6JL5+ZMpwm02Qeii/sBIWqAz2/PSCN53vB2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUj/WeVt7f92p/GTsqjDZ/w+mQ6Cz2+cE5b6SHiFzPjU9iqnynxSbJp2YiFkdNR7V5MI0qGD2gSucamw8sjMoAbKc4Dunv5CbbVJBo6GVXsqAaDvTbPx1AjwgzzztuzEfjSmuCzAgAgheR+6DwzKoXJj9GYg8BrCduakKoV/qOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTXuER5U; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so14352738a91.3;
        Sun, 05 Jan 2025 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736094346; x=1736699146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqRDxETieKo+8LV73GKB3gXqTd/uCkmgBGJiOO4mOFg=;
        b=OTXuER5UcAoJIWaMHdqMSwFQF3pYn+2Dkm+jmSRogyGaOcA3NskZQ0wM0NkXL+EH9V
         Om9yM2wIITbq8LPxoNHhwu+rrN0eKujIbSXwZ/gTXx7FTBU879zeruLlcAU9ADBlMDsP
         zG6aJLiMGOED6azyWMQPubyMRrO/xYFdtSJSZHaRy4k98aOrx/hTyzm9ncAbvOpctP3k
         GGB0k2xWc7Xmk8WMc6rYdwDOVDbF7T0tUoH2z64JUy1Mt8qd3NtyNYY+apQI1TMuabPv
         Y3cTqqWb8O77DSe3xgcdSa5P+mlepwEdlf60TnP+QdXeGBe6N+3qH+jd/Ssn+I+pDCAN
         frFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736094346; x=1736699146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqRDxETieKo+8LV73GKB3gXqTd/uCkmgBGJiOO4mOFg=;
        b=ZeFLnsqvm2e8PQsH8H5joSsIsBVsFT7q6Yz0clzA0N/pW2B313qI817l+ghfI9VgO4
         YBw/niKgCUkuWk8OLKTzx8S07WX1dkqNrdxzblXP3LKxAJdRJkDMLOpMjmY377k3yRFk
         mDU2oFuCjq3i24GmkVbukjS7ycFEx92AkON1WUxaSvHPdo17hiPLiYcQBAubs0/3O5Q+
         XgLRUwT8jUHnOcwrXr7jrIy3VZan/mYzGoUQvjC86x7rIwaesHipMf6TDkRyWkJcrEti
         7wsgXF+iXmHdwloVjwjtKIe/BriWGJmTlXViu4InZpzzqjB3H7oPJM0WKNKNS274TtrJ
         tKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUec4dvsmz5Mo72hRzVo2PpUYLnHGt8/FIhhYM7M0WCJ646268JV9IvtLgldwP8UBDx0VSldS+KqB+ggXi+SVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2F0/X4rjwV6GjDfBBiGAAfNIwi9zjKtYT8vwKVs+20EugkUcv
	CFipwy8+TmYluYuYvLewW95qavJZuWGhy4B3d30dWBcfiVxkVry2Ji1q60dRm/In3lkUIJNQiEY
	cgbOf41gWCNO+w0OMfc7+UnRImNU=
X-Gm-Gg: ASbGncu1d3+l3idY49YDwZNE8qvGtpA2WK3BNZaL8An5iNnivClHwOU06X4IAK+bN9g
	eBASRwkqBBKhYAZZAF11dvxE7z8gDx7Z9H8YfUgY=
X-Google-Smtp-Source: AGHT+IH2+khpZuwV/UXGR/BF5U6xqgXLMlviIw4B+TtjMphMUGOjhladr0Lh2wSn3HqLSS5KQs2I5FOW+J2wTf7Ziqs=
X-Received: by 2002:a17:90b:54d0:b0:2ee:c918:cd60 with SMTP id
 98e67ed59e1d1-2f452e4a7f6mr85268600a91.20.1736094346461; Sun, 05 Jan 2025
 08:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220091730.28006-1-yongxuan.wang@sifive.com>
In-Reply-To: <20241220091730.28006-1-yongxuan.wang@sifive.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Mon, 6 Jan 2025 00:25:35 +0800
Message-ID: <CAFTtA3Op9go6pi6Om=e+hXGAfMGv_kGeS4CfqXbdVhLcRW89ew@mail.gmail.com>
Subject: Re: [PATCH 0/2] selftest: fix riscv/vector tests
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, greentime.hu@sifive.com, 
	vincent.chen@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yong-Xuan Wang <yongxuan.wang@sifive.com> =E6=96=BC 2024=E5=B9=B412=E6=9C=
=8820=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:17=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Add test counts and pass message to remove warning of riscv/vector tests.
>
> Yong-Xuan Wang (2):
>   tools: selftests: riscv: Add pass message for v_initval_nolibc
>   tools: selftests: riscv: Add test count for vstate_prctl
>
>  tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 4 ++++
>  tools/testing/selftests/riscv/vector/vstate_prctl.c     | 2 ++
>  2 files changed, 6 insertions(+)
>
> --
> 2.17.1
>

For the series,

Reviewed-by: Andy Chiu <AndybnAC@gmail.com>

Thanks,
Andy

