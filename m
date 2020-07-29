Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38556231725
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 03:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgG2BTh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 21:19:37 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34438 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgG2BTg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 21:19:36 -0400
Received: by mail-il1-f195.google.com with SMTP id t4so17963473iln.1;
        Tue, 28 Jul 2020 18:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B91HiCKNmpX8gkK2k6g6Fq8/ZKsRY3otOWekC11z6P0=;
        b=rdsRJGutm2LK3yxNCr9foL+6oFGnCyDumBOCvZraevdmjo09SnDXe3tVNXr5V/qXor
         Io0vpCWzuzfvic2p0MDC+OzTuFsru9clPsUN1/TsMdKhRPI5RDOeZUbPNHLoJxASO0hS
         EiaBV/TNw36wWAzdefz1XXGo/FpaUcKHVtSkYFUlmbt8utYXT9gT5YMIFW9X1Ns2Osmt
         V/Z2PQxy3CH6IiAxPyRpg8QMSCr03Zu07OMiGbsNzePDNISu1YtV5o9BoBlNrEh3iAkG
         kjRNwEhA4US+whvLvJQ+O+CmR9TepWKKqkE9nJ5j7HuiG12DZgp+ESZ2AjjN/QoL5F5Y
         0IRw==
X-Gm-Message-State: AOAM531jjK0DV6G0aa6yJIIwoRHU1SkIUQEn986G/M9pHyhJQJhlMYSO
        aHa3+QX9MHZVIKSQiUJ27Wc=
X-Google-Smtp-Source: ABdhPJwzR5S+DRGSkHs+nrLGi+6ZpSWvxyuhezuW0Cx7i53MP5Gn8g+eaySs9KIl44OMBe6pbzCvOQ==
X-Received: by 2002:a05:6e02:8a8:: with SMTP id a8mr32682383ilt.52.1595985575405;
        Tue, 28 Jul 2020 18:19:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a24sm241191ioe.46.2020.07.28.18.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 18:19:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2605A40945; Wed, 29 Jul 2020 01:19:33 +0000 (UTC)
Date:   Wed, 29 Jul 2020 01:19:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/19] Introduce partial kernel_read_file() support
Message-ID: <20200729011933.GM4332@42.do-not-panic.com>
References: <20200724213640.389191-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 24, 2020 at 02:36:21PM -0700, Kees Cook wrote:
> v3:
> - add reviews/acks
> - add "IMA: Add support for file reads without contents" patch
> - trim CC list, in case that's why vger ignored v2
> v2: [missing from lkml archives! (CC list too long?) repeating changes here]
> - fix issues in firmware test suite
> - add firmware partial read patches
> - various bug fixes/cleanups
> v1: https://lore.kernel.org/lkml/20200717174309.1164575-1-keescook@chromium.org/

For patches 1-10:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
