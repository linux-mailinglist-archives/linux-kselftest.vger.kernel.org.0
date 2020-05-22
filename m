Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF41DEFAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 21:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgEVTHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 15:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730857AbgEVTHS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 15:07:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0074DC061A0E;
        Fri, 22 May 2020 12:07:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id yc10so14140203ejb.12;
        Fri, 22 May 2020 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=xmNwanKC++U+27ahip8lbbEDLlHHtUnV6HgVgvFbfDM=;
        b=GDNPawQaeob9K+mNF5FNjW5o7K97gJjg59+CeSgpNELRpu58JHl52mCtCCNck1pEvb
         HeMZ58GjcMB+3JZnPZjNGFu50ZDhiU05fcSRiSQrFSXBCJ5aO517JMVOHzoDFbBO3T60
         qnlzDbf5s7Br0/5RInsVsW1RA7uhRp1mzgyUGrAFjOIAaV9g0pC8U0e9WQbXzCXZwYet
         DqrLVQL6ZhVlh+lICfs24zODMFqTJ0SSF7aT4xVhXt8oxVKEvCjTjVq4eOjlnJT6xm25
         F41FFU4KAnVVQTZT1cdv+ze1DN1EPzyRpSTRK8C2V0/wIYNvJnYk969MPWkiE6ykVs9U
         B4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=xmNwanKC++U+27ahip8lbbEDLlHHtUnV6HgVgvFbfDM=;
        b=TzADA+jg38Ees1sydxc+QWscyd8YTRIjPRienrglREpFwoy6utxpRlCOiaZAzCHTJh
         eqWruwPG5ZEDIUKtYtdnnuMHkOJBW2+38zMHsVY812X1nVNfom4ERQhq2kxpS6XNXoCZ
         4FEJL/j/atXtYZ3B9uOWTqosQ23o/fGllvysAA+I1/6uMdwotDphOFAdpVwnQ0XgaSNa
         f9ahFeyhTo3uba4nL9+Eiyblla8Xfr8G9e9mDWwRYMCzs0kxSURU/SyqakN8Qcp8xsjA
         Yo2u4BY9qXjl/RySq75e7Hu+XNAcDNLvU2n0ZRyyuRpl13I2Ag62/gzmVtR/V4R1dB/i
         06sw==
X-Gm-Message-State: AOAM5307ZsnPzo/LQoxYhSBQH+W8CmEELQXIOXZakXFhrIiw90dvIaxy
        RHshVIyGKoJ7SmPK0GwacLU=
X-Google-Smtp-Source: ABdhPJwPJ0lh6giMCZwg2jnCxoteCi2ar0Wm0YeibZi4QG8ZQHgHqxFG/zwgNygvQ7Y4qWoDWBhNzw==
X-Received: by 2002:a17:906:f74c:: with SMTP id jp12mr9871203ejb.490.1590174436607;
        Fri, 22 May 2020 12:07:16 -0700 (PDT)
Received: from x230 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id df21sm7827794edb.27.2020.05.22.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 12:07:16 -0700 (PDT)
Date:   Fri, 22 May 2020 21:07:14 +0200
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
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v3] Kernel selftests: Add check if TPM devices are
 supported
Message-ID: <20200522190714.GB90663@x230>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200521144344.1886-1-Nikita.Sobolev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521144344.1886-1-Nikita.Sobolev@synopsys.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

> TPM2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> are available. In case, when these devices are not available test
> fails, but expected behaviour is skipped test.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
