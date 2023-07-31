Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033BD768BA1
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjGaGNt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGaGNs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:13:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB76E40;
        Sun, 30 Jul 2023 23:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690784026; bh=92ykIX7tsv3yIszfxJZDqwdxurd6Xt4sT0q3KP0Tw3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwqsCH1EaLqVeX1w/cWVS+2lgPokaNiGE2t8LkMcRAEveXtnUQYfn530A9nrfc2/y
         NctzieLkY9+T8y1gOXnNFwuI18MeHzeM5E4tKfhQABXHQYnfAUDk/39Vu1AGaDFwus
         zOQ1E85s8r4Yrm7aEavSMpY0CItbIkWtsYZhanQo=
Date:   Mon, 31 Jul 2023 08:13:45 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     w@1wt.eu, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tools/nolibc: add pipe() and pipe2() support
Message-ID: <a6654bc6-4b33-43bc-be3e-1e55d5cc7710@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
 <23019c9ad3a63d7026a60df8bc41934c3e74e564.1690733545.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23019c9ad3a63d7026a60df8bc41934c3e74e564.1690733545.git.tanyuan@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-31 13:50:45+0800, Yuan Tan wrote:
> [..]

> +static __attribute__((unused))
> +int pipe(int pipefd[2])
> +{
> +	pipe2(pipefd, 0);

This is missing a "return".

> +}
> +
> +
>  /*
>   * int prctl(int option, unsigned long arg2, unsigned long arg3,
>   *                       unsigned long arg4, unsigned long arg5);
> -- 
> 2.34.1
> 
