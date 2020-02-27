Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6068F172477
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 18:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgB0RDm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 12:03:42 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:62174 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729481AbgB0RDm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 12:03:42 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48SzXB3jH9z9tyX0;
        Thu, 27 Feb 2020 18:03:38 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qQ2TAJnS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lT4opiy4Qpqi; Thu, 27 Feb 2020 18:03:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48SzXB28lmz9tyWv;
        Thu, 27 Feb 2020 18:03:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582823018; bh=ivG0NenvQkR8PkrDU2mBpZ9HGooYM3SCFz7DbVUGfzY=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=qQ2TAJnSG5rWsee88j6nad+tuJ9WtixEjEin3eXlX7opv2cv4hq6hZXkvm5CACMiz
         LVQrY7R8aSu+JuZ1LAiykc8H95XuwDKbOiBPLQrTBRTecf2/Mzv2lkuzxnkm96QnDW
         q5FMafTk76Ro//h6tgtJQwVa+No5DSBj82q9iu40=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DCF7C8B880;
        Thu, 27 Feb 2020 18:03:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fKAvznOpv8mR; Thu, 27 Feb 2020 18:03:39 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82BF18B799;
        Thu, 27 Feb 2020 18:03:38 +0100 (CET)
Subject: Re: [PATCH] selftests/vm: Fix map_hugetlb length used for testing
 read and write
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <9a404a13c871c4bd0ba9ede68f69a1225180dd7e.1580978385.git.christophe.leroy@c-s.fr>
Message-ID: <797ec84e-7257-d97a-5c13-9a9d9f1f650a@c-s.fr>
Date:   Thu, 27 Feb 2020 18:03:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9a404a13c871c4bd0ba9ede68f69a1225180dd7e.1580978385.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

Le 06/02/2020 à 09:42, Christophe Leroy a écrit :
> Commit fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and
> page size in map_hugetlb") added the possibility to change the size
> of memory mapped for the test, but left the read and write test using
> the default value. This is unnoticed when mapping a length greater
> than the default one, but segfaults otherwise.
> 
> Fix read_bytes() and write_bytes() by giving them the real length.
> 
> Also fix the call to munmap().
> 
> Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page size in map_hugetlb")
> Cc: stable@vger.kernel.org

Can you also consider this one for next rc ?

Thanks
Christophe

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   tools/testing/selftests/vm/map_hugetlb.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
> index 5a2d7b8efc40..6af951900aa3 100644
> --- a/tools/testing/selftests/vm/map_hugetlb.c
> +++ b/tools/testing/selftests/vm/map_hugetlb.c
> @@ -45,20 +45,20 @@ static void check_bytes(char *addr)
>   	printf("First hex is %x\n", *((unsigned int *)addr));
>   }
>   
> -static void write_bytes(char *addr)
> +static void write_bytes(char *addr, size_t length)
>   {
>   	unsigned long i;
>   
> -	for (i = 0; i < LENGTH; i++)
> +	for (i = 0; i < length; i++)
>   		*(addr + i) = (char)i;
>   }
>   
> -static int read_bytes(char *addr)
> +static int read_bytes(char *addr, size_t length)
>   {
>   	unsigned long i;
>   
>   	check_bytes(addr);
> -	for (i = 0; i < LENGTH; i++)
> +	for (i = 0; i < length; i++)
>   		if (*(addr + i) != (char)i) {
>   			printf("Mismatch at %lu\n", i);
>   			return 1;
> @@ -96,11 +96,11 @@ int main(int argc, char **argv)
>   
>   	printf("Returned address is %p\n", addr);
>   	check_bytes(addr);
> -	write_bytes(addr);
> -	ret = read_bytes(addr);
> +	write_bytes(addr, length);
> +	ret = read_bytes(addr, length);
>   
>   	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
> -	if (munmap(addr, LENGTH)) {
> +	if (munmap(addr, length)) {
>   		perror("munmap");
>   		exit(1);
>   	}
> 
