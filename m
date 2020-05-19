Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2C1D960A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 14:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgESMQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 08:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgESMQK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 08:16:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A9FC08C5C0;
        Tue, 19 May 2020 05:16:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m185so3275669wme.3;
        Tue, 19 May 2020 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=CI8m9crALg/Xn9OTn2CBKMgQVjthPtgSj7GKK6/xrJY=;
        b=vBqmOvTO2RpDH6eAR9P3QBjukIRoBhlYcOfYsZS2KPUH2g7YNw3monWGp1OTTphsZr
         2BOEwUj0BfqLk13bC05HQvnpLhd+RXE8NX6/wusaJZ4jg+TZHXKBYhcx0jt8Eo3cJ7Hz
         Y0wBW/ahm1c5pY7qSy5U8LUOfF5KnDEj905txbJ9j9VYGvbD8skZl5FDp/1x7S8TOzra
         FiIuG06zXO5qpN6aI6/2AhgeUJMB/8Wy/Yado2WGM34H+G7tmZ5z5pCX5iuLeGc3H72O
         W9lMeK/jqmk5fHNDYm4WN4Vhe67nU0qs0ujenvJa3chTKbNCLe9tESJ41lkBoKAm41gX
         EBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=CI8m9crALg/Xn9OTn2CBKMgQVjthPtgSj7GKK6/xrJY=;
        b=GAsh3hpj/s384s3kkIAB11AdE3AKCUwL7vfsKmb0fXFtxqo8ml+8lQKLDsyJbzXuxJ
         V/OxsbPZpFmam5r+9cPKM0N8XkJkcYWMxzY4E9M/RdjxGMvkoLHpSHyBprlYMjZ0ZUq8
         OoMcKU2ESx7oW9emE6lL3+t32hyRvswBspP5ahWcO5Lpi/tleSYyjZGn9W28Kvhdavgb
         qAt89ugCgJ8gBQMV0/cKSbQiOhd3Uh6v41YOYIMiZ4o24Ug/0SeMVddOgNOy5xVftyRi
         427BzgWWa4TIeK6543p7Mv8AgwpFwbBzCfALYaqq+t2SKdUOqr215WCiSBagCU4vJCYO
         pMPg==
X-Gm-Message-State: AOAM533FQ6XVU08epT44lGiadpnEFOUBVUy0JMDRjFPOheSpZ1dbOQ9k
        q86vpWp6czd/yEGbh2gsiks=
X-Google-Smtp-Source: ABdhPJxHMUI94FzaEe4xQzVqMjormWR9atpJ2uAM5QMcxIJw4AE3uiC6h2FBqph/XlkkdbNUkyB9Sg==
X-Received: by 2002:a05:600c:2c4e:: with SMTP id r14mr5467146wmg.118.1589890568466;
        Tue, 19 May 2020 05:16:08 -0700 (PDT)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id t129sm4356833wmg.27.2020.05.19.05.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:16:07 -0700 (PDT)
Date:   Tue, 19 May 2020 14:16:05 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] Kernel selftests: Add check if tpm devices are
 supported
Message-ID: <20200519121605.GA26265@dell5510>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200519120743.41358-1-Nikita.Sobolev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519120743.41358-1-Nikita.Sobolev@synopsys.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Nikita,

> tpm2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> are available. In case, when these devices are not available test
> fails, but expected behaviour is skipped test.

> Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for v2, but I see v1 already merged in next tree since February.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20200518&id=b32694cd0724d4ceca2c62cc7c3d3a8d1ffa11fc

Kind regards,
Petr
