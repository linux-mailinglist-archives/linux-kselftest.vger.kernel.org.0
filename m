Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053417BB35E
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 10:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjJFIjp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 04:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjJFIjp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 04:39:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B393;
        Fri,  6 Oct 2023 01:39:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99357737980so332159866b.2;
        Fri, 06 Oct 2023 01:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696581581; x=1697186381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vn7Qi+HY8GjmOyb6Lxc2nxB3hB8z+OBMeLaUb2Xph7E=;
        b=lebrlE73Xpb9lliRZlsYq979kYVCMwa9JHO9WQItWoZHLk4Yw5WqEpB4NYwHXGIHdP
         P3G10yX86aRN3HF8Cr4MDs8eBG03RHPJxHR2uv8YSgfhYA2VuGDJpry/20SIp3WUY1T5
         h5sBMQMyyK51SD+iS5IyNp4AH4IPTAm6y4Jbb2hnOo80oyqDcBV//V+9sbbtzL6eizEn
         r5TdPQffPX3mZupyXakAs/OpHuwDmVwB/1A7QmKkAXeca2NaooMpHKWlyj+arw6wVTSQ
         EpBhR4NSyXTxzDtUeCvSD331njdkw3wymJsP2TlhooovY+pmxUlv/QCkNjU49K90aTOi
         23kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696581581; x=1697186381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn7Qi+HY8GjmOyb6Lxc2nxB3hB8z+OBMeLaUb2Xph7E=;
        b=E0Hzpebm2ox04WbBgVm+mA9rSgSg/dXuJDGaBItzTZl4WKibLSE2AL9rrBn0BNxD87
         SDDzBIAIGXprHdOgsmoVrz9w9rt4p8JyfvdqXVQyQnIpN64dH0/D0mMuYQAAhYVCBDmb
         gQrg0CuHdWzO+1/hXkr7pkE9ncL/mGNCZRn2xlbP1msI8Wa7oCBhigpGP/3G3BSm9WLp
         fQJF48XgstCcRR8SUqBfQkpWWPWV48rYy1f6oXHpZwxy/wxON7ZD9AJto1JfUdGLOkIO
         zBOayi2+KJPkafk13V0AcBhyhjCMP+wwRtKMrUaGiPRk5H0TndoF2YgUwpESLhTmOOjG
         cz0w==
X-Gm-Message-State: AOJu0Yx+Eq0c0KlJlvI1N2VyLtqE/31Cw/It28dYOCjnLKr1aTn/pv6s
        74ZhHgwr01Tzx11PVicf89A=
X-Google-Smtp-Source: AGHT+IHJtLZ21KkLtdxr9jpnW5HZ58MVC3B7Ri11QeI2zyTQ0rzF1nwjkGYHbiDcp130fMQ6PWYq+w==
X-Received: by 2002:a17:906:518b:b0:9b2:b9a7:2a30 with SMTP id y11-20020a170906518b00b009b2b9a72a30mr6306662ejk.67.1696581581076;
        Fri, 06 Oct 2023 01:39:41 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906a28b00b009737b8d47b6sm2477863ejz.203.2023.10.06.01.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 01:39:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Oct 2023 10:39:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6/6] selftests: futex: remove duplicate unneeded defines
Message-ID: <ZR/HypmZYM58IRj/@gmail.com>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
 <20230805073809.1753462-6-usama.anjum@collabora.com>
 <ZRvU8DXRWL9sgKug@gmail.com>
 <51273ffa-e323-44e8-8a93-bc04ee356df0@collabora.com>
 <ZR8bn/UDLypbUhJT@gmail.com>
 <b017f3e0-6682-401e-b20c-8264cd788d6f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b017f3e0-6682-401e-b20c-8264cd788d6f@collabora.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> Sorry, so the working of the change-log isn't clear enough. I'll send the 
> patch separately and with better wording.

Thank you!

	Ingo
