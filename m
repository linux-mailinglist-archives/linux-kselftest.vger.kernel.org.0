Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2150E70F1DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 11:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbjEXJML (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbjEXJMI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 05:12:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED212B;
        Wed, 24 May 2023 02:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB81662E1B;
        Wed, 24 May 2023 09:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07354C433D2;
        Wed, 24 May 2023 09:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684919526;
        bh=5HNEgVJpG7dLHIJSzg/slXqy5OSHeC5cBleX5jJ/evw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzem5TX6Ap7Uw+aheUpMNX1RBv+rP9v5Ci0CAUCQqkK/JrHNxDuic9U565y6vTfUX
         Y+nMH1Alu1fwrFxkUCXjeousR80Rf+xeIub/o9HNxuNRYaC3bWhD7YVU1fiQYhKUyk
         qoRNabUpsprNLObQhqErirx3GVbWCS/xYScPKe32KuPkeubyleST94BrL4+8H8iWeG
         7PxMsiKyRr9fbLKtEsmUuRRzU42EAxYCItE9mbjFJa3qlM4HZ+asRO5zbjmnKPGEJl
         xQpwME8sbT0Krk+XgPiMfDXu5AJpPLn3I2fgStm/PGkm4zwEbYBmttMwpFTqJuYsNr
         ptIyf4BzKsBiA==
Date:   Wed, 24 May 2023 11:12:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ziqi Zhao <astrajoan@yahoo.com>
Cc:     skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [Linux-kernel-mentorship] [PATCH] selftest: pidfd: Omit long and
 repeating outputs
Message-ID: <20230524-tausend-erlitt-b3163dd1dd05@brauner>
References: <20230523232207.363136-1-astrajoan.ref@yahoo.com>
 <20230523232207.363136-1-astrajoan@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523232207.363136-1-astrajoan@yahoo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 23, 2023 at 11:22:07PM +0000, Ziqi Zhao wrote:
> An output message:
> 
> > # # waitpid WEXITSTATUS=0
> 
> will be printed for 30,000+ times in the `pidfd_test` selftest, which
> does not seem ideal. This patch removes the print logic in the
> `wait_for_pid` function, so each call to this function does not output
> a line by default. Any existing call sites where the extra line might
> be beneficial have been modified to include extra print statements
> outside of the function calls.
> 
> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> ---

Fine by me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
