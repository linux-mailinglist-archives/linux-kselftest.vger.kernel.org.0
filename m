Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC52A5AADF2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiIBMAY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiIBMAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 08:00:24 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33DE1E3C1;
        Fri,  2 Sep 2022 05:00:22 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 1E9891A11CC;
        Fri,  2 Sep 2022 12:00:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id A19246000A;
        Fri,  2 Sep 2022 12:00:19 +0000 (UTC)
Message-ID: <7591cea9e718f6abfee14f08e97937b1c2722dd6.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Handle FILE pointer type
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date:   Fri, 02 Sep 2022 05:00:18 -0700
In-Reply-To: <20220902111923.1488671-1-mic@digikod.net>
References: <20220902111923.1488671-1-mic@digikod.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: A19246000A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: cn8fpz4gidom5be91pcx9ywmgu7e7pax
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/IgcKs53YVW32I39B6pP1mbdA0ggHUt6Y=
X-HE-Tag: 1662120019-604117
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-09-02 at 13:19 +0200, Mickaël Salaün wrote:
> When using a "FILE *" type, checkpatch considers this an error:
>   ERROR: need consistent spacing around '*' (ctx:WxV)
>   #32: FILE: f.c:8:
>   +static void a(FILE *const b)
[]
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Acked-by: Joe Perches <joe@perches.com>

> Link: https://lore.kernel.org/r/20220902111923.1488671-1-mic@digikod.net
> ---
> Changes since v1:
> https://lore.kernel.org/r/20220901145948.1456353-1-mic@digikod.net
> * Remove the FIXTURE_{DATA,VARIANT}() comments.
> * Improve commit description.
> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -576,10 +576,14 @@ our $typeKernelTypedefs = qr{(?x:
>  	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
>  	atomic_t
>  )};
> +our $typeStdioTypedefs = qr{(?x:
> +	FILE
> +)};
>  our $typeTypedefs = qr{(?x:
>  	$typeC99Typedefs\b|
>  	$typeOtherOSTypedefs\b|
> -	$typeKernelTypedefs\b
> +	$typeKernelTypedefs\b|
> +	$typeStdioTypedefs\b
>  )};
>  
>  our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
> 
> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5

