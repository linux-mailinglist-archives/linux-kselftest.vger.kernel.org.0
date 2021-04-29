Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6F36E281
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Apr 2021 02:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhD2ARV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 20:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhD2ART (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 20:17:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA06DC06138D
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 17:16:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so10008564pja.5
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 17:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=TvDH0Ufqq951p1SmGaor3zZZi0JBju1aRHwGT5Ex+6c=;
        b=QaD/VVOxxSHR992LoLrpIJQQds/+I56g/5Yghstb9fT9oxB4i1jHVKtKqdaKblE/VT
         itiQC65Rf+gWnNZ1ttu463nMM13UI4nP05lLbxGblTbKb6ISyL9STzgZzofKvlCx9HQ2
         N2kYxvrnae81cP6y+XVgJPvR02GdidKhbA+v+0fWcxhhQUp9iTg2DZddN16pOxZzNRqg
         cJizdYKQXjG73K611GqZYcEHJapZhctYriktf+3jTNHctQR/yKp0ioHbwTCu4Q6vmqy5
         m0JnwBmTlS+lybWS60ufhkYBXoIrCQLPLn/osKy7PI0vOMX8ytfB8SN+BlOR8ieCKrgr
         4e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=TvDH0Ufqq951p1SmGaor3zZZi0JBju1aRHwGT5Ex+6c=;
        b=IbTl5tRmmhROiR9hQHf/Gd3ImtO3IcWk6NV7YP/VKpteCZAX4fJgdnQOQztnOT6c81
         6B9IpfkJLx+nuTKxyqlWlilZeaFLToaT1HvY/m8iMD1M/RBLuFChrc2d5cJ1hzXXsmb1
         2VMrc8LfL22Lk2ofnyYJnqTCJlcmtjQX9DZKmGrN6XSYc0so8HFQw5BJhTw0pHexMcGU
         15MKWtMtEreaJuktz3eNrcngHnbfqcHmoKKYBxHH0XCEqGFqWE8zI+IoaeOwIiooIZ0e
         7T5drHkMW9Ij4DpBGUHGBuQOlTp627oOlu3zo7BVJBxkIL7NuxcW27nIOQO+5h9Eo3u5
         aeEw==
X-Gm-Message-State: AOAM531nNjeeBWADab6BIBpb8gY2cu3YJRb3rcJ18u0IS+bfxQG2/rRI
        PuznrlZTQjriQXHj99XtZ/GaAp3GY5ZPtJvxQes=
X-Google-Smtp-Source: ABdhPJys50Z/YYYHza7YoZTIOfavd1KBVJXo4YzEpmXV8OuSslExnOqvEO4NfWPeWKrQGQ6nzlOBmh/CM8kWGT6bs78=
X-Received: by 2002:a17:902:bd0c:b029:ed:7018:4daf with SMTP id
 p12-20020a170902bd0cb02900ed70184dafmr6285423pls.67.1619655393335; Wed, 28
 Apr 2021 17:16:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:6426:b029:19:764e:b00a with HTTP; Wed, 28 Apr 2021
 17:16:32 -0700 (PDT)
Reply-To: bwalysam@gmail.com
From:   Mr Kingsley Obiora <maryclove123@gmail.com>
Date:   Thu, 29 Apr 2021 01:16:32 +0100
Message-ID: <CAFBdPme3gUvvM1J5pFQLKgBVdmORttJJz+vTj942PpKv5dUjHA@mail.gmail.com>
Subject: Hello From Dr Kingsley Obiora
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Sir,

After our meeting held today based on your funds, the management want
to bring to your notice that we are making a special arrangement to
bring your said fund by cash through diplomatic Immunity to your
country home. Further details of this arrangement will be given to you
once you acknowledged this idea.

Waiting for your soonest response.
Kingsley Obiora
