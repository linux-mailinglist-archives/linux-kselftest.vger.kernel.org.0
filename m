Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1816E311DC6
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 15:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhBFOi4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Feb 2021 09:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhBFOiz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Feb 2021 09:38:55 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF26C06178C
        for <linux-kselftest@vger.kernel.org>; Sat,  6 Feb 2021 06:38:40 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id u7so2391685ooq.0
        for <linux-kselftest@vger.kernel.org>; Sat, 06 Feb 2021 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=OWTjK8rXt849N+r7VUE1A1baaeUQteNNVtlU/JINnmOicGiKhN85Dy+Fn031qC0+Hx
         x7ERvkjM4Y72Td3/XS7WS1IDxIcTmr5T8kHQ3/CcVcKK1x1V4ibvLCpjKbJ06fkcHab3
         Ozl8dmTg6VHe/RmHsfE1fHRQM5btqiLGWJN4SQpAPdfTFIi5p6dCfCOfazxy/8G9rATc
         dIDS9+mcxTArPpN7/qWvfbU0y0zquozIitB3AO6RGqVTBHx3see9PUbdmjqM61POr5Py
         rVJffi2/BZHTY0ddJiDiiNRf+rQBVyAzKQf6geTWRAnUJY40D6K+sPxo/PlJE5dTsEAK
         KT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=tHI73d8wHbXLNPXiOGfsrXVmMdu+YSgrxt+2aqk7XZ0SImAR5+rpQkQlfNfE5Wu8Wb
         dCLpHR1dcbbbkv1q3AC1ypZLCm+bt1hLMYlVnlW1QmgRn0oCPBfpDq6xaIWqTyD55U5B
         nijX0cUXCAMW/GcENE8BC8ix3qYxLkJjgg+AaVeNqWr2r1oY/HJigAyAlkVw9fAJpv9j
         hJOufL8/PKfZXtHCg7MJXpgsEcuJ4RZJ3EW7axa5rjS7w/S/FgeKCsTKBQEFABPqOdGZ
         QlhiEFDXym/qzcJxT8h7WUwXyTt/0AJTPv3vthXsETObzYesPm3fgfMy4IbwQ1xkE1Th
         jh7g==
X-Gm-Message-State: AOAM531E2b/2tPILpFVLpthNiftE6RHcf3wpxfinYBYXTYp5w0JgylSP
        z64zv482MCZtqETcTOntKLA4+hV1ZiefALZse/0=
X-Google-Smtp-Source: ABdhPJzo1/d6hUymQ4V657sXAIF21DxH2D8yan3L7KZMqjcSEI4Qa1deNsHtrx5qNyhcx9e/d4nG77DquSEqbladSJE=
X-Received: by 2002:a4a:945:: with SMTP id 66mr1651930ooa.1.1612622319975;
 Sat, 06 Feb 2021 06:38:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:38:39 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:38:39 +0100
Message-ID: <CAO_fDi9nCDudm08mxG9sZnd6qTf1oYt_yjCfhFfm7=_p8XG=dg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
