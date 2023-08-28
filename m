Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338E78A3B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 02:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjH1A5u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 20:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjH1A5e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 20:57:34 -0400
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA2612D;
        Sun, 27 Aug 2023 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693184248;
        bh=07E42jfJQmCYXrnwZwnudcFlZim/qk0Ysk33UK2jbQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fL/mIX1kRAlxq1knGIA1Myqrp1HJZ8diHc0UorfeWDqdAduAWbFEeHCW/GdLWHz/v
         rgi2BnC6lAES+VGcTAYmxkixjaF3aAcA860QfwnfROhWFY/PmWiZ02Jp0hOfOz5APc
         UsJciyKqtuGqAXcKiOB8w0t6mIb6kYDcb1eH20VI=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id E55B5432; Mon, 28 Aug 2023 08:57:21 +0800
X-QQ-mid: xmsmtpt1693184241tvvqacq7z
Message-ID: <tencent_D53295A257B55119C425836EA19E2CE84B07@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeyPzr2ei58d3ax5qF6ia9HTfgB1ogL+NgC+2F1c0sTf+TUN2fsk
         fg1fEJmW9Tuy8muJvbOPcqGJP9eBhU03+eF9Bm8TQUYwDWsE254ZOl642pS83DaJ67eF8AaaduLV
         cJ+o8/erGoiVhhZAcVUVrPtYiIL7sRfDRPd0ua3p1XiZoyVqJd07BX47ChomrwE1srPDEGyo8WC5
         fIne6xErB2ZRs+iwRE0tTU/yzTsBRxaOND8G+MFrIToYfHBtp1KK34B8VDCdkblSP6rPcwEsGsau
         ZkZDNdoB8iXClFsSP94I/jxVTy2nkCDXmqd0+KjDseu8caDae5kc2NKa0dUb+emunAzol9N/datx
         DKQp6RLODadFAtqWs+5e4vD4DEAkZA6szwLxCTWjcENnhzDP6t+fdp2C+5xLLTlhhcsAZrcvuJZS
         PEc3gu83mn33yrzArOZkEl9KmH9Sd9eyR9+Ou4Nu7FfHECgDyoFHSlAEcEJswIUi7rYCtP3RikbH
         XYDsJybob33EnHoGhrCX169YwXiCJVzM6Z++oBHRm3TI5BaUaqPtPaIkOo+v8oGLsw00nFhb/q52
         u5xOwR4N3rUqkCXFmlMETO137Tz5hfCMzgY/3XLtE5rL3s2qGSZ4XVVxTIT8FaR0nKwuL7JjaYEf
         JVRmpa99PwwLitm8EBMfOPo7rv7IFtOg/0v6QolNAnKcfFwdB4ctuzKro+LDoS0WJcqJ0H7zKm71
         cK9x/mIV3N9sj6A5jO8P4oSZCa8bZkIt4cWocxT9bV1o18b3Sc9ChNPgLnQPE5DohW/DtLN2sjIs
         WQu3QfVyaPMgqy4nxXzAcoxShTxX+Qpoda/QjQ8v4A2pmYkBccPPW1Mqtvi+EJb/DGT1JRfP+CBR
         wNT9VxMO8hpegeC1kTPZ7XX1WGZDeMVNZOOwsT8v9t5Fug0XKHX1d573v9ptTlk5BU9fFwKL4NPj
         gYHWtSBbDXEM0XBTyHTG8v6/2ASilQghzu55cA2TcTji4QcDoJtd9HDsTGsGBx
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Rong Tao <rtoax@foxmail.com>
To:     olsajiri@gmail.com
Cc:     alexandre.torgue@foss.st.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, chantr4@gmail.com, daniel@iogearbox.net,
        deso@posteo.net, eddyz87@gmail.com, haoluo@google.com,
        iii@linux.ibm.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        laoar.shao@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, martin.lau@linux.dev,
        mcoquelin.stm32@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
        rtoax@foxmail.com, sdf@google.com, shuah@kernel.org,
        song@kernel.org, xukuohai@huawei.com, yonghong.song@linux.dev,
        zwisler@google.com
Subject: Re: [PATCH bpf-next v8] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Mon, 28 Aug 2023 08:57:21 +0800
X-OQ-MSGID: <20230828005721.26710-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZOsZwQptH05Gn9yU@krava>
References: <ZOsZwQptH05Gn9yU@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, jirka. Thanks for your reply.

> > @@ -164,13 +165,14 @@ int main(int argc, char **argv)
> >  	}
> >  
> >  	/* initialize kernel symbol translation */
> > -	if (load_kallsyms()) {
> > +	ksyms = load_kallsyms();
> 
> if we keep the load_kallsyms/ksym_search/ksym_get_addr functions as described
> in [1] the samples/bpf would stay untouched apart from the Makefile change

Maybe we should make this modification, wouldn't it be better? After all,
not modifying the source code of samples/bpf is not really a reason not to
make modifications to load_kallsyms(), what do you think?

In addition, if we continue to keep the original ksym_search() interface,
the following problems are very difficult to deal with:

	Source code ksym_search [1]

    struct ksym *ksym_search(long key)
    {
    	int start = 0, end = sym_cnt;
    	int result;
    
    	/* kallsyms not loaded. return NULL */
    	if (sym_cnt <= 0)
    		return NULL;
    
    	while (start < end) {
    		size_t mid = start + (end - start) / 2;
    
    		result = key - syms[mid].addr;
    		if (result < 0)
    			end = mid;
    		else if (result > 0)
    			start = mid + 1;
    		else
    			return &syms[mid];                         <<<
    	}
    
    	if (start >= 1 && syms[start - 1].addr < key &&
    	    key < syms[start].addr)
    		/* valid ksym */
    		return &syms[start - 1];                       <<<
    
    	/* out of range. return _stext */
    	return &syms[0];                                   <<<
    }

The original ksym_search() interface directly returns the global syms 
address, which is also dangerous for multi-threading. If we allocate new
memory for this, it is not a perfect solution.

If we rewrite

	struct ksym *ksym_search(long key)

to
	struct ksym ksym_search(long key)

This also affects the source code in samples/bpf.

The same problem exists with ksym_get_addr().

Best wishes,
Rong Tao

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/trace_helpers.c#n100

