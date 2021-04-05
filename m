Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E493354682
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Apr 2021 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhDESEW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Apr 2021 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhDESEO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Apr 2021 14:04:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9EDC061756
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Apr 2021 11:04:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a6so5611056wrw.8
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Apr 2021 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=Bvw+tquGYXJSE3tWE333wEKuNT23nrefjiMDmDpcpL0Epv+/Ae8RSBwmekKKnSuVWm
         d8MvJ/t9l2Kwrt+yY+9w4AMn6ggMHHBR0SSxqql+NYfpRaZx/3+wBabeBN8k6YeUEtvX
         nfbgk8FWFcT4noTfRHxZWGo8askw8OF5Koo5+0rFoawXKfHB1EPdTWv28tK3vIYKV6m0
         jG4SL8rrr60DeLsp6bdRMHMIzjOjNG8bCDlE/lAK969X7JX3JI7vXtGFGGXrtl1Hvfxk
         3m3ocIdokAQD2pPQHZDl78OZBJRQ4PNkM6fLDVeO2Z3K9p7nv5kH3yR6RrdpEJ4r8gGM
         ENYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=V+ZL6IBlYhDhqaW2K8qSQL0I2+furW7I5Lbh2PK3hX0=;
        b=ljwX3Wzp6hJ180gOLlaADLJFmf4zOuzu32YUebKOt+4gQugDXqPgoD1uu48LXbWtLy
         HtMeOodfLp4FuxGwrSfwdfjeO0iVPlqLAp2FdIhRH4py2qFuSTh3vTG3eEO/t4x3qsTI
         /E9H9M7t3ZmXjjVxVASSyrcjQ+EKYCY1A37CJYITUI5gz7WHmVfxMqU9oaOhikmZh62B
         0mc9DUv2tkQxruwx5G35H04+M8O50q2TbsBV4xbWmNhBEbPT4PlDYo1UlN/4iLJCBC6W
         TLSknU9DokU20oKbuhUCs2wnJ1fpwaqBaMDmDrjrxTEPVlKhzL8/6D9QhmV2tDybQoVZ
         nddA==
X-Gm-Message-State: AOAM533RaPUEHnyjjD4BIGN4qBgovFrtjQbYnZrCVk+vfIzfeFLrW/HX
        TsVMA+JA+pZiF5vuQFzUSjU=
X-Google-Smtp-Source: ABdhPJz5MWbVaSR3201vlks2D0i5dRPHDG66+p1FubTgys9+TNogA2PJ/THyuPu5iT+gXX5tDoF0UQ==
X-Received: by 2002:a5d:694e:: with SMTP id r14mr17717442wrw.84.1617645846492;
        Mon, 05 Apr 2021 11:04:06 -0700 (PDT)
Received: from [192.168.1.152] ([102.64.185.200])
        by smtp.gmail.com with ESMTPSA id u9sm263548wmq.30.2021.04.05.11.04.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 05 Apr 2021 11:04:06 -0700 (PDT)
Message-ID: <606b5116.1c69fb81.20eb0.0ab7@mx.google.com>
From:   Vanina curt <odamawussi@gmail.com>
X-Google-Original-From: Vanina curt
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: HI,
To:     Recipients <Vanina@vger.kernel.org>
Date:   Mon, 05 Apr 2021 18:03:57 +0000
Reply-To: curtisvani9008@gmail.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

How are you? I'm Vanina. I picked interest in you and I would like to know =
more about you and establish relationship with you. i will wait for your re=
sponse. thank you.
