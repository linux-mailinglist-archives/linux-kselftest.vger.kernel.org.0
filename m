Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C706531033C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 04:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBEDJa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 22:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDJT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 22:09:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C6DC06178C;
        Thu,  4 Feb 2021 19:08:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so5920372wre.13;
        Thu, 04 Feb 2021 19:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=roDmxtRhMkm/M+rdoEt0Qt78NoV1kl723S0gA19soHTB6CWkiIDz2T11aOwbrMDY6V
         Ys2/9vOeWv0+zEvNti813WvpHKjfnE0XfvI3o55lzYSr7FMS9pqd3g90b02x1u3JMwXv
         jwm7vt6Z5cCdgHjJVZQwTlk6jYycGN4lmXW15t7CnWab1V8QrKNEtUGg2nxWlBFTAb7g
         3tyTndX449mYvfhCtAQiOPotE52eq+ceAAEmtvrmiAYxXOt34ojhq72eC7aXSQbxViap
         14gtHDNN0EAX6KfZDbdhAlBz6Ul96E/1Nt5Hdqk/v8F1BxcgEjoKqQSFFp4cmx1z4bPG
         xWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=hqf55dXwvcYwwL4sAkoYuOM6RPu6wxeec88n5sMRYiY=;
        b=ebnRiC+XjDenmt3AvTWTyBPhL5wQxLY6XCu+Qf1r+7DH2IIlSgIQVbsxCiAB29J1yl
         cf8WTyLO7J72aK1dtXBnH6HbOYZ6ZyZEggh0dvtiLZGNWtUS4yH8ivojHASUkXXXy/Bx
         ge2vCjBTLK5oPbQ3kmtxfhahKSBaskx8C4HX2h5mcKmGPlsei9J/VZUyfYAveXS1n88y
         rRU8Kxnfup4DLI/37n/AfhpIbxU/2c/pG9wIVNZ9YUUqdWlbUg9Q9A4i7R2mHfAmH66n
         DsuaorOrIJmfSzQkEURu+enaECbvEbu0NpMbMAFeDm19Riug/6MO0h/Kph9u966nGExU
         u1tg==
X-Gm-Message-State: AOAM530AkMpoPqjroYTgZUgmTMai1vckbIDjx2/em0kdtLBWU7p1IMvP
        s8kVIuknV7tYQoIm+X2AWsESY2cY2xdJNg==
X-Google-Smtp-Source: ABdhPJx+5Qj2S9+z9ZpQu+EcE/DBxvDG3vinreZmPAS2rLR2ZAQah3cfUjrD6KET2IrCGEWluPw78w==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr2434359wrm.424.1612494511485;
        Thu, 04 Feb 2021 19:08:31 -0800 (PST)
Received: from [192.168.1.6] ([154.124.28.35])
        by smtp.gmail.com with ESMTPSA id n9sm10836813wrq.41.2021.02.04.19.08.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2021 19:08:30 -0800 (PST)
Message-ID: <601cb6ae.1c69fb81.5ea54.2eaa@mx.google.com>
Sender: Skylar Anderson <barr.markimmbayie@gmail.com>
From:   calantha camara <sgt.andersonskylar0@gmail.com>
X-Google-Original-From: calantha camara
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: hi dear
To:     Recipients <calantha@vger.kernel.org>
Date:   Fri, 05 Feb 2021 03:08:24 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

do you speak Eglish
