Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7F4921ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 10:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbiARJEO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 04:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345166AbiARJEF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 04:04:05 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20F5C06175C
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 01:04:00 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id h14so53619658ybe.12
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 01:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=IAamEH5Xu1dJ3X0trVcFTPIrL7aTtcDGn5mUS4vw1a8=;
        b=NHprezroMsvNvJXQj44poYAHm3bYOXBJZX5Wg8cW9F++sdGchhDxOadiHN0N74BqVo
         LLsuxLOWO8eNb9Df+WO3omzRkxx9CES4mNA3Io5+oAgtUVpSbYHogg87+gCtw68c4I2t
         jU5NFjjkmYDNDUVEzOuCjT2//b/zcZNUhM8rDEil4EjAKikZAouVCPfFT1ek6iBkNaWB
         bcv0AUKVrFCVpxHEBYPBv8KSS3FHlu8eykSeEYJmKwrS5qbSbzeHmao2+zqXdm7uNchU
         Rqamo/TlsQaFmHXGfCx8STX0aSjqEkHcratuhlypnT20IcvCVcqt6eV72JWjrAN3qvU0
         7wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=IAamEH5Xu1dJ3X0trVcFTPIrL7aTtcDGn5mUS4vw1a8=;
        b=d9L6wh77QNVUbNn3HK/DC2IaJyrt4mcnHvxiLxyJ2ObJesazZLhW147BuZ41Tfeob2
         A8OouZjPJn0NCtlMnaaaNoGgamxT/6h98k7FNxdWoGWr4gDQUifyJoOD1fqK1IRKkcZA
         Jfz9IKn9g+9KGWdKxhTOOyCQhh1yeYbpORE3HPE1FLgiqsF6a7/3ahfDbSS2umvAqlVW
         MgYfExnhi0pfE2tzzsFamC05vXEDz2R2XHSEqpnWbyH5cgrfVKVWlyJ2zKho1PMMxqvH
         wntsg6bOCBGLQmLv5QGsuu9qM33r2pfCJFBrVuye5cGLcT/+fitoNpzm6hhszoET16nY
         ZF5g==
X-Gm-Message-State: AOAM533OMHdt/Y+mdbOyUbAED1nRtrWA/JMKCY8wR80tgeabtCgGdeFf
        CuqVRYfyEGMSxLJ6lgAXEjvRwmoiz/HAIQ3nFdk=
X-Google-Smtp-Source: ABdhPJykqN6yybQfaT0kT/1JcofcZUp4wlVhtJ/gATn7SS5XA0pfx+GW8LgTxWINZerrn1yMSBF81skqvw8cEBrK9Sg=
X-Received: by 2002:a25:e549:: with SMTP id c70mr10839900ybh.339.1642496638937;
 Tue, 18 Jan 2022 01:03:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7108:3655:0:0:0:0 with HTTP; Tue, 18 Jan 2022 01:03:58
 -0800 (PST)
Reply-To: asil.ajwad@gmail.com
From:   Asil Ajwad <graceyaogokamboule@gmail.com>
Date:   Mon, 17 Jan 2022 21:03:58 -1200
Message-ID: <CA+Yy_gCoV9jOYW1qG-5psBKMTZyzWOj2x6Pu5iusfy4TEMaBwQ@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

-- 
Greetings,

I am Mr.Asil Ajwad, I work with United Bank of Africa, can you use
an ATM Visa Card to withdraw money at, ATM Cash Machine in your
country, if yes I want to transfer abounded fund the sum of $10.5million
US-Dollars, to you from my country, this is part of the money that was
abounded by our late old client a politician who unfortunately lost
his life and was forced out of power Du to greedy act, the bank will

change the account details to your name, and apply for a Visa Card
with your details, the Visa Card will be send to you, and you can be
withdrawing money with it always, whatever any amount you withdraw
daily, you will send 60% to me and you will take 40%, the Visa Card
and the bank account will be on your name, I will be waiting for your
response for more details, thanks to you a lot for giving me your time.

regards,
Mr.Asil Ajwad.
