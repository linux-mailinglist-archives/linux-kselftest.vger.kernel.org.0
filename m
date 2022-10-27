Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0560FBC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbiJ0PWS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiJ0PVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 11:21:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739E8049B;
        Thu, 27 Oct 2022 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666884098; x=1698420098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oIFe3ETvGueK4heImMYjCz/snuv7scKeOIGa2nELdHM=;
  b=XumHiQ0STtcAelQAglZD1xkKPELcDDJ7F1oNnqh0IWOle5JIPT5aIAW4
   HyfJO/cAFMzrZTNgn2gUL6AKzaNnZdrlzvWL6YBTeLChpqBUXN/b+S5gN
   Ek26nEfFx5+eIDfkIBkll+aF4rYZhqIaytfSEcHBg0GB9kFM21isonOs4
   TdZTqctwssilg7hvR4qDk8SUv/9A5bnZyaPxwQE/HQkewBfyEjV67qdO2
   NJUldM3eptFkav+83np3KdJlv3J0esDOLgEFYd6pbSmThZz2aJYmpZaAD
   KYg364XBSTk4eo2fox5fuLLFJ0AxHGfVntbq8fprcBtgByx5K4njHs+8K
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="308245482"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="308245482"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 08:21:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="627203741"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="627203741"
Received: from vstelter-mobl.amr.corp.intel.com (HELO [10.212.214.108]) ([10.212.214.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 08:21:03 -0700
Message-ID: <6758af9b-1110-ad5a-3961-e256d5c8d576@intel.com>
Date:   Thu, 27 Oct 2022 08:21:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v9 0/9] x86: Show in sysfs if a memory node is able to do
 encryption
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <Y0hrhzprPFTK+VWV@zn.tnic>
 <CAKgze5ajp-z0+F+8Qo2z=834=i=HNa5=s54MLyrk16wQVnxCzQ@mail.gmail.com>
 <Y1pH/DuYJeo7Kyo5@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y1pH/DuYJeo7Kyo5@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/27/22 01:57, Borislav Petkov wrote:
> Well, I still think this is not going to work in all cases. SME/TME can
> be enabled but the kernel can go - and for whatever reason - map a bunch
> of memory unencrypted.

For TME on Intel systems, there's no way to make it unencrypted.  The
memory controller is doing all the encryption behind the back of the OS
and even devices that are doing DMA.  Nothing outside of the memory
controller really knows or cares that encryption is happening.
