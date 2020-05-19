Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990AC1D9615
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgESMTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 08:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgESMTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 08:19:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74753C08C5C0;
        Tue, 19 May 2020 05:19:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u1so2049593wmn.3;
        Tue, 19 May 2020 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=p60TB+Tyypr34A8h+yZQiNDu/fhAf7U+hPUWshuyPPQ=;
        b=fNDVxX4v/9yZjo6Ka/JZWCNnCthl0wRZ7qHbp9YiiWJnDSCwAOJZrvnfS2IBFci2iT
         GxDcpsIq4HJ26zb2iLdrWraDMFawnKOHbxfRGif5vGQtBb95kjErhuREsyAvTHO8xXw+
         0IlbCky1b86HJu+2SMmZNwPpQGd3YCCKsqPlXZW7vt2XbFOMkdGhn2UL9FlN8cGUvdYj
         RHSdcxZYOqZoKHJF4CjKWwMcUMYyuSV3pE0Bx793YSlWsSRMm0zn0B2O+7DIv1ZcQtMB
         K39A2AS5//Yv8xUYflkIsmUnlswZeMit//r6ivmRZIBVy8fmvcB2kyHQnZP2wNIFPY+F
         LvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=p60TB+Tyypr34A8h+yZQiNDu/fhAf7U+hPUWshuyPPQ=;
        b=GaCPasPewJ2suW/onCLQS7ea9n57h2eI1i8yJGQa7LX7mFzoNBkcMOnvXpkwHf5/C8
         fg+PHMPoCdWp31I7M/PA6nwpAv1fDvQWgRjXz3IzoQYvXLTk+RU8RpeC0YO8DvHn8v+b
         Jz0ypdo0Id8dsdlPoDyjxhf0MsYE9Ioswivw2qq7f20b6XIr9dDYopqdM/l3HGSTgPNS
         9lYoVMJbKFRth5l09iCVbM1wMOLGU+8hBoN4mo7omX239MtLm4a2pV8buICdgNYerdn7
         Ee+z7lORQK5pMvbB4/rIVmjGPeWi921uoQjdobDK0WTVmfq/424o+mR2pTgxhxRAS/Pq
         uV6w==
X-Gm-Message-State: AOAM530VSbvJPKdBh1WK91HjgMR0jW3YuFQPrl9SCOx0RjPorTscuXKB
        PJfk8Jn+8CrpF2qKRLSwbtw=
X-Google-Smtp-Source: ABdhPJxF9SfebJ0+Qelp9N3dfeat3xZSDZwELOBS8RqyzDKPS9DM4f79WmvUaB+iKCUi2iTKDF69fw==
X-Received: by 2002:a1c:4088:: with SMTP id n130mr4994461wma.43.1589890746219;
        Tue, 19 May 2020 05:19:06 -0700 (PDT)
Received: from dell5510 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id d9sm3763163wmd.10.2020.05.19.05.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:19:05 -0700 (PDT)
Date:   Tue, 19 May 2020 14:19:03 +0200
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
Message-ID: <20200519121903.GB26265@dell5510>
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

> tpm2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> are available. In case, when these devices are not available test
> fails, but expected behaviour is skipped test.

> Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
OK, I see it was also reverted by Jarkko

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20200518&id=aaa2d92efe1f972567f1691b423ab8dc606ab3a9

I wonder if only wrong shell syntax (self.flags = flags) is a problem.

Kind regards,
Petr
