Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD15B3B83
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 17:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiIIPLG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 11:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiIIPLC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 11:11:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0322EE984;
        Fri,  9 Sep 2022 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662736260; x=1694272260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vGy4fIFwjFSNzA65qv4QDCYsy+swZzfD5tvaJcOb5X4=;
  b=maglAEPBCMFqi8C/cflgtKDpV2ASrc1p2Ui21rpg+cpNTeU4DHUrmCuV
   1RiybquVl3mCHYi5VNJFP7wRqL3RosMkboX0MnjApyQkAxkdfbUMMBAj7
   e6MfEdJ/8pQu6c8+oV7vWRIaggJdSTi2b/Q6jT0k6V12/vOF2V7DRklBa
   LAga3kgWGgMzFW7M/BBwAqOBD5JO5MT1vAS3XKupikCn+bKbEwdZ3K0CJ
   bUbSJHeShnH0YfMOAHVOcH6wTZX7/TNEcDPYXVLwLyYrJRm49Rz98BQA0
   +ZSbjsINIisT/JYC3tTioHrNyKIlyZCmBCUFHKftrpKhnmW9pBk4duokw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="359217074"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="359217074"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:10:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="611085785"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.25.143])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 08:10:54 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     igt-dev@lists.freedesktop.org
Cc:     linux-kselftest@vger.kernel.org, daniel@ffwll.ch,
        kunit-dev@googlegroups.com, magalilemes00@gmail.com,
        maira.canal@usp.br, dlatypov@google.com, n@nfraprado.net,
        linux-kernel@vger.kernel.org, leandro.ribeiro@collabora.com,
        dri-devel@lists.freedesktop.org, davidgow@google.com,
        tales.aparecida@gmail.com, skhan@linuxfoundation.org,
        andrealmeid@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        brendanhiggins@google.com, twoerner@gmail.com,
        Isabella Basso <isabbasso@riseup.net>
Subject: Re: [igt-dev] [PATCH i-g-t v2 2/4] lib/igt_kmod.c: check if module is builtin before attempting to unload it
Date:   Fri, 09 Sep 2022 17:10:52 +0200
Message-ID: <13576898.RDIVbhacDa@jkrzyszt-mobl1.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220829000920.38185-3-isabbasso@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net> <20220829000920.38185-3-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Monday, 29 August 2022 02:09:18 CEST Isabella Basso wrote:
> This change makes `igt_module_unload_r` safer as it checks whether the

s/igt_module_unload_r/igt_kmod_unload_r/

> module can be unloaded before attempting it.
> 
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  lib/igt_kmod.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
> index bb6cb7bb..97cac7f5 100644
> --- a/lib/igt_kmod.c
> +++ b/lib/igt_kmod.c
> @@ -256,6 +256,9 @@ static int igt_kmod_unload_r(struct kmod_module *kmod, unsigned int flags)
>  	struct kmod_list *holders, *pos;
>  	int err = 0;
>  
> +	if (kmod_module_get_initstate(kmod) == KMOD_MODULE_BUILTIN)
> +		return err;

NIT: I think that return 0; would be more clear.  Anyway,

Acked-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

> +
>  	holders = kmod_module_get_holders(kmod);
>  	kmod_list_foreach(pos, holders) {
>  		struct kmod_module *it = kmod_module_get_module(pos);
> 




