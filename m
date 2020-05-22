Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE801DEAB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 16:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgEVO4D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 10:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbgEVO4C (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 10:56:02 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ADAA205CB;
        Fri, 22 May 2020 14:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159361;
        bh=0cKEoWpTu+DWnt1dxTx3zYaBzjzi9zNBJ/UJhCY6MEw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S2tGsp0elzP5bZPCTi84SjVeZaLlaznv1T5xlzOMg4Y0dF+KyjMmUuge2RGTdWSu2
         NdXIrSGe2fRhRE0TIIF18GNfbWdGRo2kIaIcwAVDOxMZD1ntv6qO3M0DnHJ3iOth6T
         0EJiDT9nxF+rFogASJMrv2NEMfke4sBLhm/iKjOQ=
Subject: Re: [PATCH 3/3] selftests: vdso: Add a selftest for vDSO getcpu()
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20200505174728.46594-1-broonie@kernel.org>
 <20200505174728.46594-4-broonie@kernel.org>
 <dff4dfbd-f3f1-d683-5dac-4404e9023b2e@kernel.org>
 <20200519174452.GR4611@sirena.org.uk>
From:   shuah <shuah@kernel.org>
Message-ID: <0f1a7c29-340d-f61b-b102-d300932dc92c@kernel.org>
Date:   Fri, 22 May 2020 08:55:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519174452.GR4611@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/19/20 11:44 AM, Mark Brown wrote:
> On Tue, May 19, 2020 at 11:11:28AM -0600, shuah wrote:
>> On 5/5/20 11:47 AM, Mark Brown wrote:
> 
>>> +int main(int argc, char **argv)
>>> +{
>>> +	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
>>
>> WARNING: Missing a blank line after declarations
>> WARNING: Missing a blank line after declarations
>> #135: FILE: tools/testing/selftests/vDSO/vdso_test_getcpu.c:27:
>> +	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);

A blank line after declarations here just like what checkpatch
suggests. It makes it readable.

>> +	if (!sysinfo_ehdr) {
> 
> This is the idiom in use by the existing gettimeofday test:
> 
> WARNING: Missing a blank line after declarations
> #38: FILE: tools/testing/selftests/vDSO/vdso_test_gettimeofday.c:38:
> +	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
> +	if (!sysinfo_ehdr) {
> 
> so I don't know how you want the code to look here?
> 

See above.

thanks,
-- Shuah
