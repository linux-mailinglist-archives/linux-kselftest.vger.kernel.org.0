Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246045A9C51
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiIAP5s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIAP5r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 11:57:47 -0400
X-Greylist: delayed 498 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 08:57:46 PDT
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6138286D;
        Thu,  1 Sep 2022 08:57:46 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id C355D120B54;
        Thu,  1 Sep 2022 15:49:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 4F6CC80014;
        Thu,  1 Sep 2022 15:49:25 +0000 (UTC)
Message-ID: <4f958a0c7c0aa2fce613371348477c002aa58e90.camel@perches.com>
Subject: Re: [RFC PATCH v1] checkpatch: Handle FILE pointer type
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date:   Thu, 01 Sep 2022 11:49:24 -0400
In-Reply-To: <20220901145948.1456353-1-mic@digikod.net>
References: <20220901145948.1456353-1-mic@digikod.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4F6CC80014
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: osrgtkai3soscuwdadz7yu5j6usgcu3p
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX186WoNAtkhyX/vzDIDQ/MOm09E6x6e6lZU=
X-HE-Tag: 1662047365-236167
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-09-01 at 16:59 +0200, Mickaël Salaün wrote:
> When using a "FILE *" type, checkpatch considers this an error.  Fix
> this by explicitly defining "FILE" as a common type.
[]
> Another error may be throw when we use FIXTURE_{DATA,VARIANT}() structs,
> as defined in kselftest_harness.h .
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -576,10 +576,17 @@ our $typeKernelTypedefs = qr{(?x:
>  	(?:__)?(?:u|s|be|le)(?:8|16|32|64)|
>  	atomic_t
>  )};
> +our $typeStdioTypedefs = qr{(?x:
> +	FILE
> +)};

I'm fine with this.

> +# our $typeKselftestHarnessTypedefs = qr{(?x:
> +# 	FIXTURE_(?:DATA|VARIANT)\($Ident\)
> +# )};

But not this.  Random userspace typedefs should likely
be kept in some local version of checkpatch.

Or maybe add a command line option like --additional_typedefs=<file>.

>  our $typeTypedefs = qr{(?x:
>  	$typeC99Typedefs\b|
>  	$typeOtherOSTypedefs\b|
> -	$typeKernelTypedefs\b
> +	$typeKernelTypedefs\b|
> +	$typeStdioTypedefs\b
>  )};

