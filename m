Return-Path: <linux-kselftest+bounces-48356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155FCFB84C
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 02:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F9353004ED2
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8991EB5E3;
	Wed,  7 Jan 2026 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKGDfuXs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iD/xlUe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261514A8B
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747704; cv=none; b=YMLNQTEpkH6DL3ZGQ2nj2Yv1NDttDO3dwzi9XRIITkWrpVp0iZNR+GgvUuGYyXR+xHgot/Cxs0Sj8zb7bZjtgo/46l5+j7R74A3FHOU894nKmzvcvPp7rNQD73qJyvzfvsCpVKU4tmYGOjTYUy+Slib7yQwfAj8O73w/q/JumwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747704; c=relaxed/simple;
	bh=nxYTWiOaKpyGTBrQGLRPguBdRZkgWO4MwRobssvcnVI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qpfe477aLctVzVFrb1zNwXOapRZCaviAo+TMqX9JxC+O1dPwn2hp+QggdR+OnyXTy6C50mefoRvttDXG7YvBH3Kop28/A99iZBgqltKU3hVIy1nRUvyu865eUcD0n9tIStaa+4tFht+5DmBun/mUzlht6m1yr/hExwvZlB3wAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKGDfuXs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iD/xlUe6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767747702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ndVYeGncNQkge8z7xCfAgTx6DeZHb8bhHZ5rGNYPJgE=;
	b=iKGDfuXsO7u4xynKCfp0tAKU+jCcwBcQBAwi0TYRij17YP6dh6y+D2oTDTWB29mLI3jZNL
	1NnfHJSNof1TrX7B1/94Ny9ezUPErlpbRMnNP1t76CaLFOuiTZo4nWZ/KNyHPk7jx/gSxN
	qvV+B/jFW89WV6posn/8BknD7fx/Uj0=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ozpJc5FIO6-Ins9wTxlKCA-1; Tue, 06 Jan 2026 20:01:41 -0500
X-MC-Unique: ozpJc5FIO6-Ins9wTxlKCA-1
X-Mimecast-MFC-AGG-ID: ozpJc5FIO6-Ins9wTxlKCA_1767747700
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ac34c4b41fso161109eec.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 17:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767747699; x=1768352499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ndVYeGncNQkge8z7xCfAgTx6DeZHb8bhHZ5rGNYPJgE=;
        b=iD/xlUe6GPcjsW2mARPfyYZzIJgJuykwcuu+cYOMWKcdPjiYQM4/RDElFpY3thZ9iW
         9FiBAvBrOjgB38hO7f6hMmFoJ6ig7pVYXb62d41vYaiAwfsoQY7f/tXOLBYqRQTEmSD8
         nS3MJQV4weKrMM2zhABdJTC4Z6NoDBPDiez22oi2D2drhz86MCR/vTTz/I/7uwJ3Gy7Y
         8oH0g+gVRexh09GiyiIRwrpQ1pxPneNKrovQIx1I/EUVGA7azA1F1Fm/1IgMPZEOnVYe
         gPkwubbsVLWF2JkovnHKgJZQQZNGkVoU5L7s1PYCcgjafbYg/5Jolbufma+rMWKqJbAw
         mE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767747699; x=1768352499;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndVYeGncNQkge8z7xCfAgTx6DeZHb8bhHZ5rGNYPJgE=;
        b=cZEjnns7iYnR4HiapbLqzkwIz9KfoUjT2cLwAzyPagR6guRPv9SVBg1kqHjZvm/KTm
         +D2DsAVhqY4zP+v5HR2VU2uo10TVtmXSsz3L9V1o+oIFoDww3Dbm8Z8kelh+WZ7DpjEm
         HrV3fB+gguZFFxrXsDQcXr9O4TaxUz8YtS1WzgsOftvRrZC8IEF1MsZDnu0/TGd9KiNU
         s9ex9EiYN2zamOnIF3fbmubvSIulsQRQ4QiHeynlvp0+7uBjaM3vVldSMxY3g6I0HxJC
         FGU5EM7AX7tYw1zePJ1CU7HGW0CjflQQ9Bhz3hqlqT2UzhL4OLgvTz7ZmtLVxRP3h+QW
         1aGA==
X-Forwarded-Encrypted: i=1; AJvYcCURqB65jGcc9pGHjB3jalfYAwSJpnh3QcjPIpue2h8Cwt0QkbV6Kjx38rvJhzuQpbsMx1LeNwZt+phSMTBZ0b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH844k1HO5tI4fjb6SbiAidS9bOHV1UujtpoMmNFyPRnBT5nII
	Qd8v0u75hsIzjoD/2hN8EIccCchjWiK5b3sSxu1K0E/tlAincBipj5JlGoAetDbyLi8s3/bEnVy
	aLKRv+7V+tJT6UoSTCQsQ1Sp3rRltd9gcNIrJF11pG65OhQ2mVK1MQFw1/ThLRjJjyJJQx04bAt
	zmWBFmIWJqiJvJrrp87IvROOqJZ8f14CO6JuO55mEbx7nXOvSCFOBqhl3GDqA1
X-Gm-Gg: AY/fxX4ICkgJ/Lcav5/KFs0nE3LQUUABCNIvYMyn1jHp6Ai6VoYBgkw+CDynzxMYNDL
	dbHXdPlkPGP5nEkrJFErgqwTCzII6exHZH6Q903Kisc9UyvffVlVId/BAk4y0EeZBdXovvmKdvd
	vNTHXdCPxnGJmLxNnodRj6PtxJerKADCVtfT9kRCpUosZaSN0WQK0fxwh7i2Gdv3i2nXo=
X-Received: by 2002:a05:7300:51ca:b0:2ae:556b:76f2 with SMTP id 5a478bee46e88-2b16fd9fe6fmr2837523eec.6.1767747697960;
        Tue, 06 Jan 2026 17:01:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfcBuNVl+RcQ6hf5GWUZJ5q0sEMoIt7mN9RSM5Vo+b6GS4E4oPnWI+O/DeytlfZLGFbJEhi7WJlRzojGDpDYc=
X-Received: by 2002:a05:7300:51ca:b0:2ae:556b:76f2 with SMTP id
 5a478bee46e88-2b16fd9fe6fmr2837425eec.6.1767747694371; Tue, 06 Jan 2026
 17:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Li Wang <liwang@redhat.com>
Date: Wed, 7 Jan 2026 09:01:22 +0800
X-Gm-Features: AQt7F2oo-qTjdulw5KFenYHLWIwl0YehbH-CY7dg8wdDjmx2eHyhuTmqubW1gLk
Message-ID: <CAEemH2eN8FF4-sgnNSC-pO0pFw3O6R_JQ8iyoi2JHoGM3toBrw@mail.gmail.com>
Subject: Trailers missing for some commits in linux-next 20260106
To: sfr@canb.auug.org.au, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Those patch trailers (Signed-off-by, Reviewed-by, Acked-by, etc.) are
missing in the linux-next tree.
Do you know what happened? What should I do to add back that?

commit 8bd5f5187 ("selftests/mm/charge_reserved_hugetlb.sh: add waits
with timeout helper")
commit 378d74dfd ("selftests/mm/charge_reserved_hugetlb: drop mount
size for hugetlbfs")
commit 99f5e30c3 ("selftests/mm/write_to_hugetlbfs: parse -s as size_t")


Original:
  - [PATCH v3 1/3] selftests/mm/write_to_hugetlbfs: parse -s as size_t
    https://lore.kernel.org/linux-kselftest/20251221122639.3168038-2-liwang@redhat.com/

  - [PATCH v3 2/3] selftests/mm/charge_reserved_hugetlb: drop mount
size for hugetlbfs
    https://lore.kernel.org/linux-kselftest/20251221122639.3168038-3-liwang@redhat.com/

  - [PATCH v3 3/3] selftests/mm/charge_reserved_hugetlb.sh: add waits
with timeout helper
    https://lore.kernel.org/linux-kselftest/20251221122639.3168038-4-liwang@redhat.com/


-- 
Regards,
Li Wang


