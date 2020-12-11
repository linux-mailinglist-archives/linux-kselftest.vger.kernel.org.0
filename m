Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AF42D6C80
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 01:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393578AbgLKA1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 19:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394279AbgLKA0p (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 19:26:45 -0500
Date:   Thu, 10 Dec 2020 16:26:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607646364;
        bh=W+aIeXEMowSZOI3JDHh69UVLiv+fZPoXoAY1sASMcDM=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=CmyXX34/ABbzB0pImfJUoCDOHH48HCqvpS39UbfswQayTEFIphemlRfCx1SsdgQhR
         jsMbdLbo1GdyZH2V4Qi8R4XtL+5xxsLV4+CJSgYQl5XMYfwT/GC+T79Ow1WoRJklgn
         JKezvVtZ+y/iUrV7MsKuq6eHvw0ndnHuUrdB5zRTC0jc2lerLF/1HnCcF7sWQxM8L0
         Ys3h9FG0xFQc/zW3FxLvUFYxLZmVPDkrpX+DbcbdV7keflOVZj7illpwTKazjrEBIR
         /8PdJwK1umG9GRXYxlBvvU8eP5GiiMXKNLgrEtutEYxmEZ8SPXABeJHLEYyv5hH4Cr
         jS1rKHqreuHCQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        keescook@chromium.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH] selftests/harness: pass variant to teardown
Message-ID: <20201210162603.009d1597@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201210231010.420298-1-willemdebruijn.kernel@gmail.com>
References: <20201210231010.420298-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 10 Dec 2020 18:10:10 -0500 Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> FIXTURE_VARIANT data is passed to FIXTURE_SETUP and TEST_F as variant.
> 
> In some cases, the variant will change the setup, such that expections
> also change on teardown. Also pass variant to FIXTURE_TEARDOWN.
> 
> The new FIXTURE_TEARDOWN logic is identical to that in FIXTURE_SETUP,
> right above.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

IDK where we want to draw the line between reusing fixtures creating
separate ones, some test cases are completely skipped in the example 
you provide. But in principle the harness change is fine by me:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
