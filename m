Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8218FCE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 19:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCWSo4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 14:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgCWSo4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 14:44:56 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3AA205ED;
        Mon, 23 Mar 2020 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584989096;
        bh=UTEdod0XswHd4h4dEhBmu1eigXJyrh0YqzA06V8vrM8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=yR1NMPmL/VLhy1BBwpZ0LEz5UeERaC0GuOdP+fAB+sS930wtP2zyX/rA71WEbxaOT
         un6Gi+CjjDgYviScOXexxxlOJIeTBDc/sXVKP5I2Z8okRx2eC4IOi57vQsb0evYAGk
         k8c7hp94tKHRd3VIVkrSZK+Fb7hTP6++v0cpuuDI=
Subject: Re: [PATCH v1] kunit: tool: add missing test data file content
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        heidifahim@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200323173653.41305-1-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <e5f7db19-4468-8679-9ed1-3565a0adcfc0@kernel.org>
Date:   Mon, 23 Mar 2020 12:44:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323173653.41305-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/23/20 11:36 AM, Brendan Higgins wrote:
> A test data file for one of the kunit_tool unit tests was missing; add
> it in so that unit tests can run properly.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Shuah, this is a fix for a broken test. Can you apply this for 5.7?

Can you please add more details on what kind of data this file supplies
and which test fails if it doesn't exist.

> ---
>   .../testing/kunit/test_data/test_pound_sign.log  | Bin 0 -> 1656 bytes
>   1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..28ffa5ba03bfa81ea02ea9d38e7de7acf3dd9e5d 100644
> GIT binary patch
> literal 1656
> zcmah}U2EGg6n$=g#f7|Vtj^>lPBOzDM#o@mlt9+Kgd${FPEBlGBgsqs?{^h<Y3h$o
> zFBaGLocpP>13GNVmW<8=R3_K%5Q9W*u~4upWe`4q(jqBTdcAw?ZG=v-jA5@FZ|^*5
> zoU$NALGF+lEFssq<A{~zdHR7p&7+U(X~E!_yGM{l@40vQ%(~pazHH!+GB!sI;iCKZ
> zY69Cjp-?V{LrnyMQ5I_>Rp5<1_i#FmdPY1z2tkYI|M1-7PdS}Ub_h8eK~m)?&(I;{
> zd<2<NV1vyl7BWOggn_Hc5ba`wRu)R=x;oPiRuheYD}$9XJTpphG^wKX*mr|pw(;#T
> zTvPxWb#R&-VC|~9KeFD0ooNCooO~P|@vNKL)n#t&WQm2JSh%gFRMuv7!M#yqYailx
> z8TM&AUN~yqVM$ThVIE55OcVU4mW$eHC#dHEeUvCiE1wT#?U%cS^A_HAK$VqiIBG75
> z($V`G!unJPuo@k2@gj4y7$WV7g73Ls@d32giPqc=`3mz^u|IR`05hOx29+=__XXIv
> z%Xf#6<%P11b*dyatBVv$thED!=x%_Ts?sj1OY%b*t$Y}rODc$J2is^#<A~w+w`~mf
> zCs_oC7u=9pAjzurLE}*e38}&1-KX^pd*7wM-Q35(VDtTJOgeOnB`K*rii#c_+)*qi
> zNQ+5Dqv>MG0wcp<uf!}(SCXw)kqXk>xCSP@rQbRs58c`TmTbn>%WO@TFp;w*gB6RU
> km;Ljlo8cvfMVVCc>`K4bOfE$-fO&T9$C>+RbV7Fh7t6}$ApigX
> 
> literal 0
> HcmV?d00001
> 
> 
> base-commit: 021ed9f551da33449a5238e45e849913422671d7
> 

thanks,
-- Shuah
