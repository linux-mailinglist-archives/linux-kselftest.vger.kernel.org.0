Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F24BBBA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiBRPCQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 10:02:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiBRPCN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 10:02:13 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD16F18C2F2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 07:01:54 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id a28so15204926qvb.10
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 07:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qQOuPloDj1FDvrT18I7yp3YumR1JEJ9ojjlV/rcHoPw=;
        b=RoS0gyblqR/tsGfQ7lArc8WXX3kNZMvPTfZET3nsnl+Rr8n361EoMRIfa1S+T8g8oc
         NmAlJEUUOZ5XHaM5YrjNSr5VsFbJTayGS5be9bu+8ZuTGnnxnkPavDlHAMpATFRtc11K
         fiKwKgEOqF+51vJxLCJG62RY8EQ2KpYmP7mAntkiGoPgLp6RQG9Lz93DB55QoyA5iy4K
         jD0aW9yE0JKDtqB8vCY2rRZ02xMADfrBesx1EB/DYj+qq78BrufP6AkXF4xsqmELAlVq
         1FXz/tX3UyRzucAxKzmHRYKSZZAyzlWABCgkRcxEK/GH/tUhjJjJ7pXdKtahQ8czEgJj
         SqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qQOuPloDj1FDvrT18I7yp3YumR1JEJ9ojjlV/rcHoPw=;
        b=YzUVCOt+OxRqZPdFnhepNqLDc9hWLDQiY8AkpXZflx0xLdkbXxuQYmU9DvJD6mL18V
         RibCemcRa1nnZwOKAMQU9Dwj4acOPSdxr5qHag0gy4stuN9AqLy+KNs3TwNB5m0pNYnt
         8VWhgBaOzu1kpCR81gX+gVJOdE9UUq7AQQG8SesRWBRqISwmJErE5Yg9XCPVasQC6oCM
         iKHUa1TZ+gBWGE96TlVkeFhF5GtZXMya8b6nZOfYFwh+R6NdOz4ArepbOK84vt51CWix
         7Flm6uqRj0xZN8e7XtrkyQmWKinVmgo72MbTAEFds/pHEq7FmVYpBz2Vd1C9tv0gk9bc
         Ejqw==
X-Gm-Message-State: AOAM531yFXSAztbTBrFWkXg9tlWgpl4Dn2EI24DYhQUZGZgrkSXdQRj8
        J77yc1SzJjJYYTNCxcUw4W7Vyw==
X-Google-Smtp-Source: ABdhPJxj9yyCZvW5c4Ugzq0ieNoelSzlHZ5AUX07DsgnGoll6g+QZTPyJ2Fq/jgnUxsgsAq5KC011A==
X-Received: by 2002:ac8:7fd5:0:b0:2cf:93ff:5638 with SMTP id b21-20020ac87fd5000000b002cf93ff5638mr7063274qtk.435.1645196514006;
        Fri, 18 Feb 2022 07:01:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s4sm23008395qko.113.2022.02.18.07.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:01:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nL4lb-006cts-Vr; Fri, 18 Feb 2022 11:01:51 -0400
Date:   Fri, 18 Feb 2022 11:01:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Gow <davidgow@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-um@lists.infradead.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, felix.kuehling@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] kunit: tool: Disable broken options for --alltests
Message-ID: <20220218150151.GD1037534@ziepe.ca>
References: <20220218075727.2737623-1-davidgow@google.com>
 <20220218075727.2737623-5-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218075727.2737623-5-davidgow@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 18, 2022 at 03:57:27PM +0800, David Gow wrote:
> There are a number of Kconfig options which break compilation under UML with
> allyesconfig.  As kunit_tool's --alltests option is based on allyesconfig and
> UML, we need to update the list of broken options to make --alltests build
> again.
> 
> Note that, while this does build again, it still segfaults on startup,
> so more work remains to be done.
> 
> They are:
> - CONFIG_VFIO_PCI: Needs ioport_map/ioport_unmap.
> - CONFIG_INFINIBAND_RDMAVT: Needs cpuinfo_x86 and __copy_user_nocache

It doesn't make sense to patch qib and then turn this option off, it
is required to build qib.

Jason
